//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitAppCoordinator {

    private let navigator = NavigatorController()

    init(window: UIWindow) {
        window.rootViewController = navigator.rootViewController
    }

    func start() {
    }
}
