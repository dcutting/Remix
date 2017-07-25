//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol HasDetailViewFactory {
    var detailViewFactory: DetailViewFactory { get }
}

protocol DetailViewFactory {
    func make() -> DetailView
}

protocol DetailView: Navigatable {
    var viewData: DetailViewData? { get set }
}

struct DetailViewData {
    let title: String
}
