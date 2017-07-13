//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol Navigatable {}

protocol Navigator {
    func push(view: Navigatable)
}

protocol HasNavigator {
    var navigator: Navigator { get }
}
