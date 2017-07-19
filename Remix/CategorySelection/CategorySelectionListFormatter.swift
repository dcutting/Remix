//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CategorySelectionListFormatter {

    func prepare(categories: [Category]) -> CategorySelectionListViewData {
        let items = categories.map { category -> CategorySelectionListItem in
            let hasChildren = !category.children.isEmpty
            return CategorySelectionListItem(categoryID: category.categoryID, title: category.title, hasChildren: hasChildren)
        }
        return CategorySelectionListViewData(title: "Select category", items: items)
    }
}
