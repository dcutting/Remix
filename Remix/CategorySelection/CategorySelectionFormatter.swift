//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

class CategorySelectionFormatter {

    func prepare(categories: [Core.Category]) -> CategorySelectionViewData {
        let items = categories.map { category -> CategorySelectionViewDataItem in
            let hasChildren = !category.children.isEmpty
            return CategorySelectionViewDataItem(categoryID: category.categoryID, title: category.title, hasChildren: hasChildren)
        }
        return CategorySelectionViewData(title: "Select category", items: items)
    }
}
