//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

extension Navigatable {

    var viewController: UIViewController? {
        return self as? UIViewController
    }
}

class NavigatorController: UINavigationController, Navigator {

    private var popPoints = [UIViewController]()

    func push(view: Navigatable) {
        guard let viewController = view.viewController else { return }
        pushViewController(viewController, animated: true)
    }

    func pop() {
        if let popPoint = popPoints.popLast() {
            popToViewController(popPoint, animated: true)
        } else {
            popToRootViewController(animated: true)
        }
    }

    func setPopPoint() {
        guard let popPoint = topViewController else { return }
        popPoints.append(popPoint)
    }
}
