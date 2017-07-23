//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryListFormatter {

    func prepare(ads: [ClassifiedAd], categories: [Category]) -> DiscoveryListViewData {
        let items = ads.map { ad -> DiscoveryListItem in
            let category = categories.first { category in
                category.categoryID == ad.category
            }
            let categoryName = category?.title ?? ""
            return DiscoveryListItem(classifiedAdID: ad.classifiedAdID, title: ad.title, category: categoryName)
        }
        return DiscoveryListViewData(items: items)
    }
}
