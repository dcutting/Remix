//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Entity
import Services

class AppCoordinator {

    let groupService: MockGroupService
    let groupRecommendationService: MockGroupRecommendationService
    let advertService: MockAdvertService

    var platformAppCoordinator: Any?

    init() {
        let groups = [
            Group(groupID: "1", parent: nil, children: ["2", "5"], title: "Bicycles", description: ""),
            Group(groupID: "2", parent: "1", children: ["3", "4"], title: "Off road bikes", description: ""),
            Group(groupID: "3", parent: "2", children: [], title: "Trail bikes", description: ""),
            Group(groupID: "4", parent: "2", children: [], title: "Mountain bikes", description: ""),
            Group(groupID: "5", parent: "1", children: [], title: "Racers", description: ""),
            Group(groupID: "10", parent: nil, children: [], title: "Cars", description: "")
        ]
        groupService = MockGroupService()
        groupService.groups = groups

        groupRecommendationService = MockGroupRecommendationService(defaultGroupID: "10")
        groupRecommendationService.mappings = [
            ("mountain", "4"),
            ("racing", "5"),
            ("bike", "3"),
            ("car", "10"),
            ("truck", "10")
        ]

        let adverts = [
            Advert(advertID: "1", title: "Specialized", description: "A battered mountain bike well past its glory days.", groupID: "4"),
            Advert(advertID: "2", title: "Cervelo R2", description: "A superb racing bike in mint condition. Only used once to compete in the Tour de France.", groupID: "5"),
            Advert(advertID: "3", title: "Fiat 500", description: "The Fiat 500 is a rear-engined two-door, four seat, small city car manufactured and marketed by Fiat Automobiles from 1957 to 1975 over a single generation in 2-door saloon and 2-door station wagon bodystyles.", groupID: "10"),
            Advert(advertID: "4", title: "Apollo Jewel", description: "A lightweight yet strong aluminium frame makes the Apollo Jewel Women's Mountain Bike a standout when it comes to value for money.", groupID: "4")
        ]
        advertService = MockAdvertService()
        advertService.adverts = adverts
    }

    func start(window: UIWindow) {

        if UI_USER_INTERFACE_IDIOM() == .pad {
            platformAppCoordinator = start_iPad(window: window)
        } else {
            platformAppCoordinator = start_iPhone(window: window)
        }
    }

    private func start_iPad(window: UIWindow) -> Any {
        let deps = SplitAppCoordinator.Dependencies(advertService: advertService, groupService: groupService, groupRecommendationService: groupRecommendationService)
        let coordinator = SplitAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }

    private func start_iPhone(window: UIWindow) -> Any {
        let deps = NavigationAppCoordinator.Dependencies(advertService: advertService, groupService: groupService, groupRecommendationService: groupRecommendationService)
        let coordinator = NavigationAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }
}
