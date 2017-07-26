//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol DiscoveryListViewFactory {
    func make() -> DiscoveryListView
}

protocol DiscoveryListView: Navigatable {
    weak var delegate: DiscoveryListViewDelegate? { get set }
    var viewData: DiscoveryListViewData? { get set }
}

protocol DiscoveryListViewDelegate: class {
    func didSelect(advertID: AdvertID)
    func doesWantFilters()
}

struct DiscoveryListViewData {
    let items: [DiscoveryListItem]
}

struct DiscoveryListItem {
    let advertID: AdvertID
    let title: String
    let category: String
}
