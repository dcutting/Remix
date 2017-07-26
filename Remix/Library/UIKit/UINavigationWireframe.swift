//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class UINavigationWireframeFactory: NavigationWireframeFactory {
    func make() -> NavigationWireframe {
        return UINavigationWireframe()
    }
}

// Implements the NavigationWireframe for use with UIKit components (using a UINavigationController).
class UINavigationWireframe: UINavigationController, NavigationWireframe {

    private var popCheckpoints = [UIViewController]()

    init() {
        super.init(nibName: nil, bundle: nil)
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("use init()")
    }

    func push(view: Navigatable) {
        guard let viewController = view.viewController else { return }
        pushViewController(viewController, animated: true)
    }

    func popToLastCheckpoint() {
        if let popCheckpoint = popCheckpoints.popLast() {
            popToViewController(popCheckpoint, animated: true)
        } else {
            popToRootViewController(animated: true)
        }
    }

    func setPopCheckpoint() {
        guard let popPoint = topViewController else { return }
        popCheckpoints.append(popPoint)
    }
}

extension UINavigationWireframe: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController)
        else {
            return
        }

        guard let navigatable = fromViewController as? Navigatable else { return }

        navigatable.navigationWireframeDidGoBack()
    }
}
