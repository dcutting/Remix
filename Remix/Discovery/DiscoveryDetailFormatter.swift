//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

class DiscoveryDetailFormatter {
    func prepare(advert: Advert) -> AdvertDetailViewData {
        return AdvertDetailViewData(title: advert.title)
    }
}
