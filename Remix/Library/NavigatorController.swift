//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

extension Navigatable {

    var viewController: UIViewController? {
        return self as? UIViewController
    }
}

class NavigatorController: NSObject, Navigator {

    let navigationController = UINavigationController()
    private var popPoints = [UIViewController]()

    func push(view: Navigatable) {
        guard let viewController = view.viewController else { return }
        navigationController.pushViewController(viewController, animated: true)
    }

    func pop() {
        if let popPoint = popPoints.popLast() {
            navigationController.popToViewController(popPoint, animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }

    func setPopPoint() {
        guard let popPoint = navigationController.topViewController else { return }
        popPoints.append(popPoint)
    }
}

