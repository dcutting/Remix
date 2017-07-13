//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

extension Navigatable {

    var viewController: UIViewController? {
        return self as? UIViewController
    }
}

extension UINavigationController: Navigator {

    func push(view: Navigatable) {
        guard let viewController = view.viewController else { return }
        pushViewController(viewController, animated: true)
    }
}
