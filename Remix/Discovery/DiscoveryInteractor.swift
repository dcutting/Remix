//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    let classifiedAdService: ClassifiedAdService = SampleClassifiedAdService()
    let categoryService: CategoryService = SampleCategoryService()
    
    func update(selectedCategoryID: CategoryID?, completion: @escaping ([ClassifiedAd], [Category]) -> Void) {
        classifiedAdService.fetchClassifiedAds { ads in
            categoryService.fetchCategories { categories in
                let filteredAds = filter(ads: ads, for: selectedCategoryID)
                completion(filteredAds, categories)
            }
        }
    }

    private func filter(ads: [ClassifiedAd], for categoryID: CategoryID?) -> [ClassifiedAd] {
        guard let categoryID = categoryID else { return ads }
        let filteredAds = ads.filter { ad in
            ad.categoryID == categoryID
        }
        return filteredAds
    }

    func fetchDetail(for classifiedAdID: ClassifiedAdID, completion: (ClassifiedAd?) -> Void) {
        classifiedAdService.fetchClassifiedAd(for: classifiedAdID) { classifiedAd in
            completion(classifiedAd)
        }
    }
}
