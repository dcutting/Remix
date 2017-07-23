//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitAppCoordinator {

    private let splitCoordinator = UISplitCoordinator()
    private let discoveryCoordinator: SplitDiscoveryCoordinator

    init(window: UIWindow) {
        window.rootViewController = splitCoordinator.viewController
        discoveryCoordinator = SplitDiscoveryCoordinator(splitCoordinator: splitCoordinator)
    }

    func start() {
        discoveryCoordinator.start()
    }
}
