//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class UISplitCoordinator: UISplitViewController, SplitCoordinator, Viewable {

    init() {
        super.init(nibName: nil, bundle: nil)
        preferredDisplayMode = .allVisible
    }

    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("use init()")
    }

    var master: Viewable? {
        didSet {
            guard let viewController = master?.viewController else { return }
            viewControllers = [viewController]
        }
    }

    var detail: Viewable? {
        didSet {
            guard let viewController = detail?.viewController else { return }
            showDetailViewController(viewController, sender: nil)
        }
    }
}
