//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol Navigatable: Viewable {
    func navigatorDidGoBack()
}

extension Navigatable {
    // Override this in your view if you want to do something when the view is popped
    // from the navigator, such as notify a delegate that the operation has been aborted.
    // Typically this is used to handle the case when the user has tapped the
    // back button in a UINavigationController.
    func navigatorDidGoBack() {}
}

protocol Navigator {
    func push(view: Navigatable)
    func pop()
    func setPopCheckpoint()
}

protocol HasNavigator {
    var navigator: Navigator { get }
}
