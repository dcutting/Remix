//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol Navigatable {}

protocol Navigator {
    func push(view: Navigatable)
    func push(view: Navigatable, onPop: @escaping () -> Void)
    func pop()
    func setPopCheckpoint()
}

protocol HasNavigator {
    var navigator: Navigator { get }
}

