//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryListViewFakeWireframe: DiscoveryListViewWireframe {
    func make() -> DiscoveryListView {
        return DiscoveryListViewFake()
    }
}

class DiscoveryListViewFake: DiscoveryListView {
    weak var delegate: DiscoveryListViewDelegate?
    var viewData: DiscoveryListViewData?
}
