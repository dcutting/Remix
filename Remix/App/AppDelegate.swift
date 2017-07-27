//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Any?

    let advertService = SampleAdvertService()
    let categoryService = MockCategoryService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        configureMockCategoryService()

        if UI_USER_INTERFACE_IDIOM() == .pad {
            appCoordinator = start_iPad(window: window)
        } else {
            appCoordinator = start_iPhone(window: window)
        }

        window.makeKeyAndVisible()
        return true
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
}
