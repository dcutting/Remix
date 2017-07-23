//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class UISplitCoordinator: UISplitViewController, SplitCoordinator, Viewable {

    var master: Viewable? {
        didSet {
            guard let viewController = master?.viewController else { return }
            viewControllers = [viewController]
            preferredDisplayMode = .allVisible
        }
    }

    var detail: Viewable? {
        didSet {
            guard let viewController = detail?.viewController else { return }
            showDetailViewController(viewController, sender: nil)
        }
    }
}
