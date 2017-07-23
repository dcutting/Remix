//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitAppCoordinator {

    private let masterDetailCoordinator = SplitMasterDetailCoordinator()
    private let discoveryCoordinator: SplitDiscoveryCoordinator

    init(window: UIWindow) {
        window.rootViewController = masterDetailCoordinator.viewController
        discoveryCoordinator = SplitDiscoveryCoordinator(splitCoordinator: masterDetailCoordinator)
    }

    func start() {
        discoveryCoordinator.start()
    }
}
