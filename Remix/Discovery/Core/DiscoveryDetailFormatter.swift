//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class DiscoveryDetailFormatter {
    func prepare(advert: Advert) -> AdvertDetailViewData {
        return AdvertDetailViewData(title: advert.title)
    }
}
