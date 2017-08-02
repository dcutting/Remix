//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

protocol ItemDetailViewFactory {
    func make() -> ItemDetailView
}

protocol ItemDetailView: Navigatable {
    var viewData: ItemDetailViewData? { get set }
}

struct ItemDetailViewData {
    let title: String
    let detail: String
}
