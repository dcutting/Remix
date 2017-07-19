//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryFormatter {

    func prepare(ads: [ClassifiedAd]) -> DiscoveryListViewData {
        let items = ads.map { ad in
            DiscoveryListItem(title: ad.title, category: ad.category)
        }
        return DiscoveryListViewData(items: items)
    }
}
