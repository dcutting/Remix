//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

protocol AdvertDetailViewFactory {
    func make() -> AdvertDetailView
}

protocol AdvertDetailView: Navigatable {
    var viewData: AdvertDetailViewData? { get set }
}

struct AdvertDetailViewData {
    let title: String
}
