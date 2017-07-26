//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class AdvertListFormatter {

    func prepare(adverts: [Advert], categories: [Category]) -> AdvertListViewData {
        let items = adverts.map { advert in
            makeItem(from: advert, categories: categories)
        }
        return AdvertListViewData(items: items)
    }

    private func makeItem(from advert: Advert, categories: [Category]) -> AdvertListViewDataItem {
        let categoryName = name(for: advert.categoryID, categories: categories)
        return AdvertListViewDataItem(advertID: advert.advertID, title: advert.title, category: categoryName)
    }

    private func name(for categoryID: CategoryID, categories: [Category]) -> String {
        let category = categories.first { category in
            category.categoryID == categoryID
        }
        let categoryName = category?.title ?? ""
        return categoryName
    }
}
