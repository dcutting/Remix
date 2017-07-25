//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol Navigatable: Viewable {
    // Implement this in your view if you want to do something when the view is popped
    // from the navigation coordinator, such as notify a delegate that the operation
    // has been aborted. Typically this is used to handle the case when the user has
    // tapped the back button in a UINavigationController.
    func navigationCoordinatorDidGoBack()
}

extension Navigatable {
    // By default, ignore back events.
    func navigationCoordinatorDidGoBack() {}
}

protocol NavigationCoordinatorWireframe {
    func make() -> NavigationCoordinator
}

protocol NavigationCoordinator: Viewable {
    func push(view: Navigatable)
    func popToLastCheckpoint()
    func setPopCheckpoint()
}

protocol HasNavigationCoordinator {
    var navigationCoordinator: NavigationCoordinator { get }
}
