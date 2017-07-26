//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DetailViewFakeFactory: DetailViewFactory {
    func make() -> DetailView {
        return DetailViewFake()
    }
}

class DetailViewFake: DetailView {
    var viewData: DetailViewData?
}
