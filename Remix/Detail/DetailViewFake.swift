//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DetailViewFakeWireframe: DetailViewWireframe {
    var view: DetailView {
        return DetailViewFake()
    }
}

class DetailViewFake: DetailView {
    var viewData: DetailViewData?
}
