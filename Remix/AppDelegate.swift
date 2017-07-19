//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        let navigator = NavigatorController()
        window.rootViewController = navigator

        appCoordinator = AppCoordinator(navigator: navigator)
        appCoordinator?.start()

        window.makeKeyAndVisible()

        return true
    }
}
