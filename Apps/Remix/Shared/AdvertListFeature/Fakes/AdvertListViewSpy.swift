//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class AdvertListViewSpy: AdvertListView {
    weak var delegate: AdvertListViewDelegate?
    var viewData: AdvertListViewData?
}
