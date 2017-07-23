//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryListFormatter {

    func prepare(ads: [ClassifiedAd], categories: [Category]) -> DiscoveryListViewData {
        let items = ads.map { ad in
            makeItem(from: ad, categories: categories)
        }
        return DiscoveryListViewData(items: items)
    }

    private func makeItem(from ad: ClassifiedAd, categories: [Category]) -> DiscoveryListItem {
        let categoryName = name(for: ad.category, categories: categories)
        return DiscoveryListItem(classifiedAdID: ad.classifiedAdID, title: ad.title, category: categoryName)
    }

    private func name(for adCategoryID: CategoryID, categories: [Category]) -> String {
        let category = categories.first { category in
            category.categoryID == adCategoryID
        }
        let categoryName = category?.title ?? ""
        return categoryName
    }
}
