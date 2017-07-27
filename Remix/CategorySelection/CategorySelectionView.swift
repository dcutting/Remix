//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

protocol CategorySelectionViewFactory {
    func make() -> CategorySelectionView
}

protocol CategorySelectionView: Navigatable {
    weak var delegate: CategorySelectionViewDelegate? { get set }
    var viewData: CategorySelectionViewData? { get set }
}

protocol CategorySelectionViewDelegate: class {
    func didSelect(categoryID: CategoryID)
    func didDeselectAll()
    func didAbortSelection(fromView: CategorySelectionView)
}

struct CategorySelectionViewData {
    let title: String
    let items: [CategorySelectionViewDataItem]
}

struct CategorySelectionViewDataItem {
    let categoryID: CategoryID
    let title: String
    let hasChildren: Bool
}
