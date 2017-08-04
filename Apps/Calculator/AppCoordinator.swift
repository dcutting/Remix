//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class AppCoordinator {

    let calculator: CalculatorCoordinator

    init() {
        let sumViewFactory = SumViewControllerFactory()
        let primeViewFactory = PrimeViewControllerFactory()

        calculator = CalculatorCoordinator(sumViewFactory: sumViewFactory, primeViewFactory: primeViewFactory)
    }

    func start(window: UIWindow) {
        calculator.start()
        window.rootViewController = calculator.sumView?.viewController
    }
}
