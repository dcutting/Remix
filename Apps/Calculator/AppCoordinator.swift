//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class AppCoordinator {

    var calculator = CalculatorCoordinator()

    func start(window: UIWindow) {
        calculator.start()
        window.rootViewController = calculator.sumView?.viewController
    }
}
