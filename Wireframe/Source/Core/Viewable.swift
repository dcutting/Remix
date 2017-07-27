//  Copyright © 2017 cutting.io. All rights reserved.

public protocol Viewable: class {
    func present(view: Viewable)
    func dismiss()
}
