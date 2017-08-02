//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

extension Viewable {
    
    public var viewController: UIViewController? {
        return self as? UIViewController
    }

    public func present(view: Viewable) {
        guard let presented = view.viewController else { return }
        presented.modalPresentationStyle = .formSheet
        viewController?.present(presented, animated: true)
    }

    public func present(view: Viewable, forSeconds: Double) {
        guard let presented = view.viewController else { return }
        present(view: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + forSeconds) {
            presented.dismiss(animated: true)
        }
    }

    public func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
