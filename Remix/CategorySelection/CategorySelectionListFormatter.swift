//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CategorySelectionListFormatter {

    func prepare(categories: [Category]) -> SelectionListViewData {
        let items = categories.map { category -> SelectionListItem in
            let hasChildren = !category.children.isEmpty
            return SelectionListItem(title: category.title, hasChildren: hasChildren)
        }
        return SelectionListViewData(title: "Select category", items: items)
    }
}
