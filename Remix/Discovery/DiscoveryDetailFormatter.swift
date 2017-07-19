//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryDetailFormatter {
    func prepare(item: ClassifiedAd) -> DetailViewData {
        return DetailViewData(title: item.title, category: item.category)
    }
}
