//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryDetailFormatter {
    func prepare(ad: ClassifiedAd) -> DetailViewData {
        return DetailViewData(title: ad.title)
    }
}
