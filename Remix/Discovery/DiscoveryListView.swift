//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol DiscoveryListView: Navigatable {
    weak var delegate: DiscoveryListViewDelegate? { get set }
    var viewData: DiscoveryListViewData? { get set }
}

protocol DiscoveryListViewDelegate: class {
    func didSelectItem(at index: Int)
    func doesWantFilters()
}

struct DiscoveryListViewData {
    let items: [DiscoveryListItem]
}

struct DiscoveryListItem {
    let title: String
    let category: String
}
