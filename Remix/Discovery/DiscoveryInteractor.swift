//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    let advertService: AdvertService = SampleAdvertService()
    let categoryService: CategoryService = SampleCategoryService()
    
    func update(selectedCategoryID: CategoryID?, completion: @escaping ([Advert], [Category]) -> Void) {
        advertService.fetchAdverts { ads in
            categoryService.fetchCategories { categories in
                let filteredAds = filter(ads: ads, for: selectedCategoryID)
                completion(filteredAds, categories)
            }
        }
    }

    private func filter(ads: [Advert], for categoryID: CategoryID?) -> [Advert] {
        guard let categoryID = categoryID else { return ads }
        let filteredAds = ads.filter { ad in
            ad.categoryID == categoryID
        }
        return filteredAds
    }

    func fetchDetail(for advertID: AdvertID, completion: (Advert?) -> Void) {
        advertService.fetchAdverts(for: advertID) { advert in
            completion(advert)
        }
    }
}
