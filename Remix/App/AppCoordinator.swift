//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class AppCoordinator {

    let advertService = MockAdvertService()
    let categoryService = MockCategoryService()

    var platformAppCoordinator: Any?

    func start(window: UIWindow) {

        configureMockAdvertService()
        configureMockCategoryService()

        if UI_USER_INTERFACE_IDIOM() == .pad {
            platformAppCoordinator = start_iPad(window: window)
        } else {
            platformAppCoordinator = start_iPhone(window: window)
        }
    }

    private func start_iPad(window: UIWindow) -> Any {
        let deps = SplitAppCoordinator.Dependencies(advertService: advertService, categoryService: categoryService)
        let coordinator = SplitAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }

    private func start_iPhone(window: UIWindow) -> Any {
        let deps = NavigationAppCoordinator.Dependencies(advertService: advertService, categoryService: categoryService)
        let coordinator = NavigationAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }

    private func configureMockAdvertService() {
        let adverts = [
            Advert(advertID: "1", title: "Specialized", categoryID: "4"),
            Advert(advertID: "2", title: "Cervelo R2", categoryID: "5"),
            Advert(advertID: "3", title: "Fiat 500", categoryID: "10"),
            Advert(advertID: "4", title: "Apollo Jewel", categoryID: "4")
        ]
        advertService.adverts = adverts
    }

    private func configureMockCategoryService() {
        let categories = [
            Category(categoryID: "1", parent: nil, children: ["2", "5"], title: "Bicycles"),
            Category(categoryID: "2", parent: "1", children: ["3", "4"], title: "Off road bikes"),
            Category(categoryID: "3", parent: "2", children: [], title: "Trail bikes"),
            Category(categoryID: "4", parent: "2", children: [], title: "Mountain bikes"),
            Category(categoryID: "5", parent: "1", children: [], title: "Racers"),
            Category(categoryID: "10", parent: nil, children: [], title: "Cars")
        ]
        categoryService.categories = categories
    }
}
