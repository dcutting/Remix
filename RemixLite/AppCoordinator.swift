//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Wireframe
import Entity
import Services
import GroupSelection

class AppCoordinator {

    let groupService = MockGroupService()
    var appCoordinator: GroupSelectionCoordinator?

    let navigationWireframe = UINavigationWireframe()

    func start(window: UIWindow) {

        configureMockGroupService()

        let deps = GroupSelectionFeature.Dependencies(groupService: groupService, groupSelectionViewFactory: GroupSelectionViewControllerFactory())
        let feature = GroupSelectionFeature(dependencies: deps)
        let coordinator = feature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
        coordinator.delegate = self
        appCoordinator = coordinator

        window.rootViewController = navigationWireframe.viewController

        navigationWireframe.setPopCheckpoint()

        coordinator.start()
    }

    private func configureMockGroupService() {
        let groups = [
            Group(groupID: "1", parent: nil, children: ["2", "5"], title: "Bicycles"),
            Group(groupID: "2", parent: "1", children: ["3", "4"], title: "Off road bikes"),
            Group(groupID: "3", parent: "2", children: [], title: "Trail bikes"),
            Group(groupID: "4", parent: "2", children: [], title: "Mountain bikes"),
            Group(groupID: "5", parent: "1", children: [], title: "Racers"),
            Group(groupID: "10", parent: nil, children: [], title: "Cars")
        ]
        groupService.groups = groups
    }
}

extension AppCoordinator: GroupSelectionCoordinatorDelegate {

    func didSelect(groupID: GroupID?) {
        if let groupID = groupID {
            let detailView = AdvertDetailViewControllerFactory().make()
            groupService.fetchGroup(for: groupID) { group in
                guard let group = group else { return }
                detailView.viewData = CategoryDetailFormatter().prepare(group: group)
                self.navigationWireframe.popToLastCheckpoint(animated: false)
                self.navigationWireframe.setPopCheckpoint()
                self.navigationWireframe.push(view: detailView)
            }
        } else {
            navigationWireframe.popToLastCheckpoint()
            navigationWireframe.setPopCheckpoint()
        }
    }

    func didCancelSelection() {
    }
}

class CategoryDetailFormatter {
    func prepare(group: Group) -> AdvertDetailViewData {
        return AdvertDetailViewData(title: group.title)
    }
}
