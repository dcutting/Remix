//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class AdvertDetailViewFakeFactory: AdvertDetailViewFactory {
    func make() -> AdvertDetailView {
        return AdvertDetailViewFake()
    }
}

class AdvertDetailViewFake: AdvertDetailView {
    var viewData: AdvertDetailViewData?
}
