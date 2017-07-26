//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryListFormatter {

    func prepare(adverts: [Advert], categories: [Category]) -> DiscoveryListViewData {
        let items = adverts.map { advert in
            makeItem(from: advert, categories: categories)
        }
        return DiscoveryListViewData(items: items)
    }

    private func makeItem(from advert: Advert, categories: [Category]) -> DiscoveryListViewDataItem {
        let categoryName = name(for: advert.categoryID, categories: categories)
        return DiscoveryListViewDataItem(advertID: advert.advertID, title: advert.title, category: categoryName)
    }

    private func name(for categoryID: CategoryID, categories: [Category]) -> String {
        let category = categories.first { category in
            category.categoryID == categoryID
        }
        let categoryName = category?.title ?? ""
        return categoryName
    }
}
