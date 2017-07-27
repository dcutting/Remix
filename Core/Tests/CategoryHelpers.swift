//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

func makeCategory(categoryID: CategoryID, parent: CategoryID? = nil, children: [CategoryID] = [], title: String? = nil) -> Core.Category {
    return Category(categoryID: categoryID, parent: parent, children: children, title: title ?? "dummy title")
}
