//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

func makeCategory(categoryID: CategoryID, children: [CategoryID] = []) -> Category {
    return Category(categoryID: categoryID, parent: nil, children: children, title: "dummy title")
}
