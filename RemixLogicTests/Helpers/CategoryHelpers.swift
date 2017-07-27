//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

func makeCategory(categoryID: CategoryID, children: [CategoryID] = [], title: String? = nil) -> Category {
    return Category(categoryID: categoryID, parent: nil, children: children, title: title ?? "dummy title")
}
