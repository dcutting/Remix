//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol DetailView {
    var viewData: DetailViewData? { get set }
}

struct DetailViewData {
    let title: String
    let category: String
}
