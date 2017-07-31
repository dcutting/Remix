//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

protocol AdvertDetailViewFactory {
    func make() -> AdvertDetailView
}

protocol AdvertDetailView: Navigatable {
    var viewData: AdvertDetailViewData? { get set }
}

struct AdvertDetailViewData {
    let title: String
    let detail: String
}
