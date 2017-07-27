//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Core

class AppCoordinator {

    let advertService = MockAdvertService()
    let groupService = MockGroupService()

    var platformAppCoordinator: Any?

    func start(window: UIWindow) {

        configureMockAdvertService()
        configureMockGroupService()

        if UI_USER_INTERFACE_IDIOM() == .pad {
            platformAppCoordinator = start_iPad(window: window)
        } else {
            platformAppCoordinator = start_iPhone(window: window)
        }
    }

    private func start_iPad(window: UIWindow) -> Any {
        let deps = SplitAppCoordinator.Dependencies(advertService: advertService, groupService: groupService)
        let coordinator = SplitAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }

    private func start_iPhone(window: UIWindow) -> Any {
        let deps = NavigationAppCoordinator.Dependencies(advertService: advertService, groupService: groupService)
        let coordinator = NavigationAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }

    private func configureMockAdvertService() {
        let adverts = [
            Advert(advertID: "1", title: "Specialized", groupID: "4"),
            Advert(advertID: "2", title: "Cervelo R2", groupID: "5"),
            Advert(advertID: "3", title: "Fiat 500", groupID: "10"),
            Advert(advertID: "4", title: "Apollo Jewel", groupID: "4")
        ]
        advertService.adverts = adverts
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
