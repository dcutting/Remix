//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

// Implements the NavigationCoordinator for use with UIKit components (using a UINavigationController).
class UINavigationCoordinator: UINavigationController, NavigationCoordinator, Viewable {

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

    func pop() {
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

extension UINavigationCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController)
        else {
            return
        }

        guard let navigatable = fromViewController as? Navigatable else { return }

        navigatable.navigationCoordinatorDidGoBack()
    }
}
