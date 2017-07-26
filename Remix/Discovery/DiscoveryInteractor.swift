//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    let advertService: AdvertService = SampleAdvertService()
    let categoryService: CategoryService = SampleCategoryService()
    
    func update(selectedCategoryID: CategoryID?, completion: @escaping ([Advert], [Category]) -> Void) {
        advertService.fetchAdverts { adverts in
            categoryService.fetchCategories { categories in
                let filteredAdverts = filter(adverts: adverts, for: selectedCategoryID)
                completion(filteredAdverts, categories)
            }
        }
    }

    private func filter(adverts: [Advert], for categoryID: CategoryID?) -> [Advert] {
        guard let categoryID = categoryID else { return adverts }
        let filteredAdverts = adverts.filter { advert in
            advert.categoryID == categoryID
        }
        return filteredAdverts
    }

    func fetchDetail(for advertID: AdvertID, completion: (Advert?) -> Void) {
        advertService.fetchAdvert(for: advertID) { advert in
            completion(advert)
        }
    }
}
