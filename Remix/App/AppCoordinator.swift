//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Entity
import Services

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
            Advert(advertID: "1", title: "Specialized", description: "A battered mountain bike well past its glory days.", groupID: "4"),
            Advert(advertID: "2", title: "Cervelo R2", description: "A superb racing bike in mint condition. Only used once to compete in the Tour de France.", groupID: "5"),
            Advert(advertID: "3", title: "Fiat 500", description: "The Fiat 500 is a rear-engined two-door, four seat, small city car manufactured and marketed by Fiat Automobiles from 1957 to 1975 over a single generation in 2-door saloon and 2-door station wagon bodystyles.", groupID: "10"),
            Advert(advertID: "4", title: "Apollo Jewel", description: "A lightweight yet strong aluminium frame makes the Apollo Jewel Women's Mountain Bike a standout when it comes to value for money.", groupID: "4")
        ]
        advertService.adverts = adverts
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
}
