//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    let classifiedAdService: ClassifiedAdService = SampleClassifiedAdService()
    let categoryService: CategoryService = SampleCategoryService()
    
    func update(selectedCategoryID: CategoryID?, completion: @escaping ([ClassifiedAd], [Category]) -> Void) {
        classifiedAdService.fetchClassifiedAds { classifiedAds in
            categoryService.fetchCategories { categories in
                if let selected = selectedCategoryID {
                    let filteredAds = classifiedAds.filter { ad in
                        ad.category == selected
                    }
                    completion(filteredAds, categories)
                } else {
                    completion(classifiedAds, categories)
                }
            }
        }
    }

    func fetchDetail(for classifiedAdID: ClassifiedAdID, completion: (ClassifiedAd?) -> Void) {
        classifiedAdService.fetchClassifiedAd(for: classifiedAdID) { classifiedAd in
            completion(classifiedAd)
        }
    }
}
