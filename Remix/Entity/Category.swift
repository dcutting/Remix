//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

typealias CategoryID = String

struct Category {
    let categoryID: CategoryID
    let parent: CategoryID?
    let children: [CategoryID]
    let title: String
}

extension Category: Equatable {
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.categoryID == rhs.categoryID &&
            lhs.parent == rhs.parent &&
            lhs.children == rhs.children &&
            lhs.title == rhs.title
    }
}
