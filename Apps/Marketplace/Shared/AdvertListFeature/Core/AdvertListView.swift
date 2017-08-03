//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

protocol AdvertListViewFactory {
    func make() -> AdvertListView
}

protocol AdvertListView: Navigatable {
    weak var delegate: AdvertListViewDelegate? { get set }
    var viewData: AdvertListViewData? { get set }
}

protocol AdvertListViewDelegate: class {
    func didSelect(advertID: AdvertID)
    func didSelectNewAdvertAction()
    func didSelectFiltersAction()
}

struct AdvertListViewData {
    let items: [AdvertListViewDataItem]
}

struct AdvertListViewDataItem {
    let advertID: AdvertID
    let title: String
    let group: String
}
