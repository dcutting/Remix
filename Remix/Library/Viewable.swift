//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

protocol Viewable: class {}

extension Viewable {
    public var viewController: UIViewController? {
        return self as? UIViewController
    }
}
