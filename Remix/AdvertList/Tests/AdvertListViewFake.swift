//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class AdvertListViewFakeFactory: AdvertListViewFactory {
    func make() -> AdvertListView {
        return AdvertListViewFake()
    }
}

class AdvertListViewFake: AdvertListView {
    weak var delegate: AdvertListViewDelegate?
    var viewData: AdvertListViewData?
}
