//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Any?

    let categoryService = SampleCategoryService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        if UI_USER_INTERFACE_IDIOM() == .pad {
            appCoordinator = start_iPad(window: window)
        } else {
            appCoordinator = start_iPhone(window: window)
        }

        window.makeKeyAndVisible()
        return true
    }

    private func start_iPad(window: UIWindow) -> Any {
        let deps = SplitAppCoordinator.Dependencies(categoryService: categoryService)
        let coordinator = SplitAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }

    private func start_iPhone(window: UIWindow) -> Any {
        let deps = NavigationAppCoordinator.Dependencies(categoryService: categoryService)
        let coordinator = NavigationAppCoordinator(window: window, dependencies: deps)
        coordinator.start()
        return coordinator
    }
}
