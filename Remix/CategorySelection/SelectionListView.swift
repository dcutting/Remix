//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol SelectionListView {
    weak var delegate: SelectionListViewDelegate? { get set }
    var viewData: SelectionListViewData { get set }
}

protocol SelectionListViewDelegate: class {
    func didSelectItem(at index: Int)
}

struct SelectionListViewData {
    let items: [SelectionListItem]
}

struct SelectionListItem {
    let title: String
    let hasChildren: Bool
}
