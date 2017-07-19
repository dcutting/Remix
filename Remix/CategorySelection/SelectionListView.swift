//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol HasSelectionListViewWireframe {
    var selectionListViewWireframe: SelectionListViewWireframe { get }
}

protocol SelectionListViewWireframe {
    func make() -> SelectionListView
}

protocol SelectionListView: Navigatable {
    weak var delegate: SelectionListViewDelegate? { get set }
    var viewData: SelectionListViewData? { get set }
}

protocol SelectionListViewDelegate: class {
    func didSelectItem(at index: Int)
}

struct SelectionListViewData {
    let title: String
    let items: [SelectionListItem]
}

struct SelectionListItem {
    let title: String
    let hasChildren: Bool
}
