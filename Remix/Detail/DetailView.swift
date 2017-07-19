//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol HasDetailViewWireframe {
    var detailViewWireframe: DetailViewWireframe { get }
}

protocol DetailViewWireframe {
    var view: DetailView { get }
}

protocol DetailView: Navigatable {
    var viewData: DetailViewData? { get set }
}

struct DetailViewData {
    let title: String
    let category: String
}
