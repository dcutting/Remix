//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

extension Navigatable {

    var viewController: UIViewController? {
        return self as? UIViewController
    }
}

// Implements the Navigator for use with UIKit components (using a UINavigationController).
class NavigatorController: NSObject, Navigator {

    var rootViewController: UIViewController {
        return navigationController
    }

    private let navigationController = UINavigationController()
    private var popCheckpoints = [UIViewController]()

    override init() {
        super.init()
        navigationController.delegate = self
    }

    func push(view: Navigatable) {
        guard let viewController = view.viewController else { return }
        navigationController.pushViewController(viewController, animated: true)
    }

    func pop() {
        if let popCheckpoint = popCheckpoints.popLast() {
            navigationController.popToViewController(popCheckpoint, animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }

    func setPopCheckpoint() {
        guard let popPoint = navigationController.topViewController else { return }
        popCheckpoints.append(popPoint)
    }
}

extension NavigatorController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController)
        else {
            return
        }

        guard let navigatable = fromViewController as? Navigatable else { return }

        navigatable.navigatorDidGoBack()
    }
}
