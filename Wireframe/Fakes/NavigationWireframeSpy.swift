//  Copyright © 2017 cutting.io. All rights reserved.

public class NavigationWireframeSpy: NavigationWireframe {

    var pushedViews = [Navigatable]()

    public var topView: Navigatable? {
        return pushedViews.last
    }

    public init() {}

    public func push(view: Navigatable) {
        pushedViews.append(view)
    }

    public func popToLastCheckpoint() {
    }

    public func setPopCheckpoint() {
    }

    public func unsetPopCheckpoint() {
    }

    public func setLeftButton(title: String, target: Any, selector: Selector) {
    }
}
