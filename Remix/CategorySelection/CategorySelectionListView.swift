//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol HasCategorySelectionListViewWireframe {
    var categorySelectionListViewWireframe: CategorySelectionListViewWireframe { get }
}

protocol CategorySelectionListViewWireframe {
    func make() -> CategorySelectionListView
}

protocol CategorySelectionListView: Navigatable {
    weak var delegate: CategorySelectionListViewDelegate? { get set }
    var viewData: CategorySelectionListViewData? { get set }
}

protocol CategorySelectionListViewDelegate: class {
    func didSelect(categoryID: CategoryID)
    func didDeselectAll()
    func didAbortSelection(view: CategorySelectionListView)
}

struct CategorySelectionListViewData {
    let title: String
    let items: [CategorySelectionListItem]
}

struct CategorySelectionListItem {
    let categoryID: CategoryID
    let title: String
    let hasChildren: Bool
}
