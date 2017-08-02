//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Service
import GroupSelectionFeature

class AppCoordinator {

    let groupService = MockGroupService()
    let navigationWireframe = UINavigationWireframe()
    let groupDetailFormatter = GroupDetailFormatter()
    let viewFactory = ItemDetailViewControllerFactory()

    var appCoordinator: GroupSelectionCoordinator?

    func start(window: UIWindow) {
        window.rootViewController = navigationWireframe.viewController
        configureMockGroupService()
        startGroupSelection()
    }
}

extension AppCoordinator: GroupSelectionCoordinatorDelegate {

    private func startGroupSelection() {
        navigationWireframe.setPopCheckpoint()
        appCoordinator = makeGroupSelectionCoordinator()
        appCoordinator?.delegate = self
        appCoordinator?.start()
    }

    func didSelect(groupID: GroupID?) {
        if let groupID = groupID {
            pushDetailView(for: groupID)
        } else {
            popToGroupSelectionRoot()
        }
    }

    private func pushDetailView(for groupID: GroupID) {
        groupService.fetchGroup(for: groupID) { result in
            switch result {
            case let .success(group):
                self.pushDetailView(group: group)
            case .error:
                self.presentError()
            }
        }
    }

    private func pushDetailView(group: Group) {
        let view = viewFactory.make()
        view.viewData = groupDetailFormatter.prepare(group: group)
        navigationWireframe.push(view: view)
    }

    private func presentError() {
        print("could not load group details")  // See AutoGroupInsertionCoordinator example
    }

    private func popToGroupSelectionRoot() {
        navigationWireframe.popToLastCheckpoint()
        navigationWireframe.setPopCheckpoint()
    }

    func didCancelSelection() {
        // Cannot happen in this app, since group selection is the root feature.
    }
}

extension AppCoordinator {

    private func configureMockGroupService() {

        groupService.groups = [
            Group(groupID: "1", parent: nil, children: ["2", "5"], title: "Bicycles", description: ""),
            Group(groupID: "2", parent: "1", children: ["3", "4"], title: "Off road bikes", description: ""),
            Group(groupID: "3", parent: "2", children: [], title: "Trail bikes", description: "Trail bikes are a development of XC bikes that are generally used by recreational mountain bikers either at purpose built trail centers or on natural off-road trails."),
            Group(groupID: "4", parent: "2", children: [], title: "Mountain bikes", description: "A mountain bike is a bicycle designed for off-road cycling. Mountain bikes share similarities with other bikes, but incorporate features designed to enhance durability and performance in rough terrain."),
            Group(groupID: "5", parent: "1", children: [], title: "Racers", description: "The most important characteristics about a racing bicycle are its weight and stiffness which determine the efficiency at which the power from a rider's pedal strokes can be transferred to the drive-train and subsequently to its wheels. To this effect racing bicycles may sacrifice comfort for speed."),
            Group(groupID: "10", parent: nil, children: [], title: "Cars", description: "A car (or automobile) is a wheeled motor vehicle used for transportation. They run primarily on roads, seat one to eight people, have four tires, and mainly transport people rather than goods.")
        ]
    }

    private func makeGroupSelectionCoordinator() -> GroupSelectionCoordinator {

        let deps = GroupSelectionFeature.Dependencies(
            groupService: groupService,
            groupSelectionViewFactory: GroupSelectionViewControllerFactory()
        )
        let feature = GroupSelectionFeature(dependencies: deps)

        return feature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
    }
}
