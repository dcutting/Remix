//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Wireframe
import Entity
import Services
import GroupSelection

class AppCoordinator {

    let groupService = MockGroupService()
    let navigationWireframe = UINavigationWireframe()
    var appCoordinator: GroupSelectionCoordinator?

    func start(window: UIWindow) {

        window.rootViewController = navigationWireframe.viewController
        navigationWireframe.setPopCheckpoint()

        configureMockGroupService()

        appCoordinator = makeGroupSelectionCoordinator()
        appCoordinator?.delegate = self
        appCoordinator?.start()
    }

    private func configureMockGroupService() {
        let groups = [
            Group(groupID: "1", parent: nil, children: ["2", "5"], title: "Bicycles", description: ""),
            Group(groupID: "2", parent: "1", children: ["3", "4"], title: "Off road bikes", description: ""),
            Group(groupID: "3", parent: "2", children: [], title: "Trail bikes", description: "Trail bikes are a development of XC bikes that are generally used by recreational mountain bikers either at purpose built trail centers or on natural off-road trails."),
            Group(groupID: "4", parent: "2", children: [], title: "Mountain bikes", description: "A mountain bike is a bicycle designed for off-road cycling. Mountain bikes share similarities with other bikes, but incorporate features designed to enhance durability and performance in rough terrain."),
            Group(groupID: "5", parent: "1", children: [], title: "Racers", description: "The most important characteristics about a racing bicycle are its weight and stiffness which determine the efficiency at which the power from a rider's pedal strokes can be transferred to the drive-train and subsequently to its wheels. To this effect racing bicycles may sacrifice comfort for speed."),
            Group(groupID: "10", parent: nil, children: [], title: "Cars", description: "A car (or automobile) is a wheeled motor vehicle used for transportation. They run primarily on roads, seat one to eight people, have four tires, and mainly transport people rather than goods.")
        ]
        groupService.groups = groups
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

extension AppCoordinator: GroupSelectionCoordinatorDelegate {

    func didSelect(groupID: GroupID?) {
        if let groupID = groupID {
            pushDetailView(for: groupID)
        } else {
            navigationWireframe.popToLastCheckpoint()
            navigationWireframe.setPopCheckpoint()
        }
    }

    private func pushDetailView(for groupID: GroupID) {
        groupService.fetchGroup(for: groupID) { group in
            guard let group = group else { return }
            let detailView = ItemDetailViewControllerFactory().make()
            detailView.viewData = GroupDetailFormatter().prepare(group: group)
            self.navigationWireframe.push(view: detailView)
        }
    }

    func didCancelSelection() {
    }
}
