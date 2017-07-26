//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryListFormatter {

    func prepare(ads: [Advert], categories: [Category]) -> DiscoveryListViewData {
        let items = ads.map { ad in
            makeItem(from: ad, categories: categories)
        }
        return DiscoveryListViewData(items: items)
    }

    private func makeItem(from ad: Advert, categories: [Category]) -> DiscoveryListItem {
        let categoryName = name(for: ad.categoryID, categories: categories)
        return DiscoveryListItem(advertID: ad.advertID, title: ad.title, category: categoryName)
    }

    private func name(for adCategoryID: CategoryID, categories: [Category]) -> String {
        let category = categories.first { category in
            category.categoryID == adCategoryID
        }
        let categoryName = category?.title ?? ""
        return categoryName
    }
}
