//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol Navigatable {
    var navigationID: UUID { get }
    func didGoBack()
}

extension Navigatable {
    func didGoBack() {}
}

protocol Navigator {
    func push(view: Navigatable)
    func pop()
    func setPopCheckpoint()
}

protocol HasNavigator {
    var navigator: Navigator { get }
}

