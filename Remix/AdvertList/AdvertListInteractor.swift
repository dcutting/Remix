//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

class AdvertListInteractor {
    
    let advertService: AdvertService
    let categoryService: CategoryService

    init(advertService: AdvertService, categoryService: CategoryService) {
        self.advertService = advertService
        self.categoryService = categoryService
    }

    func update(for categoryID: CategoryID?, completion: @escaping ([Advert], [Core.Category]) -> Void) {
        advertService.fetchAdverts { adverts in
            categoryService.fetchCategories { categories in
                let filteredAdverts = filter(adverts: adverts, for: categoryID)
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
}
