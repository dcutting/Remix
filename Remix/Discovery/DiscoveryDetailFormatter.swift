//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryDetailFormatter {
    func prepare(advert: Advert) -> DetailViewData {
        return DetailViewData(title: advert.title)
    }
}
