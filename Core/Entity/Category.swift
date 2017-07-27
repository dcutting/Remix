//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

public typealias CategoryID = String

public struct Category {
    public let categoryID: CategoryID
    public let parent: CategoryID?
    public let children: [CategoryID]
    public let title: String

    public init(categoryID: CategoryID, parent: CategoryID?, children: [CategoryID], title: String) {
        self.categoryID = categoryID
        self.parent = parent
        self.children = children
        self.title = title
    }
}

extension Category: Equatable {
    public static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.categoryID == rhs.categoryID &&
            lhs.parent == rhs.parent &&
            lhs.children == rhs.children &&
            lhs.title == rhs.title
    }
}
