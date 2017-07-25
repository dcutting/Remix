//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

extension Viewable {
    var viewController: UIViewController? {
        return self as? UIViewController
    }

    func present(view: Viewable) {
        guard let presented = view.viewController else { return }
        presented.modalPresentationStyle = .formSheet
        viewController?.present(presented, animated: true)
    }
}
