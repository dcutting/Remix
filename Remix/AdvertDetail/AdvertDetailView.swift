//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol AdvertDetailViewFactory {
    func make() -> AdvertDetailView
}

protocol AdvertDetailView: Navigatable {
    var viewData: AdvertDetailViewData? { get set }
}

struct AdvertDetailViewData {
    let title: String
}
