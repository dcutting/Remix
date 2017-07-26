//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    let advertService: AdvertService

    init(advertService: AdvertService, categoryService: CategoryService) {
        self.advertService = advertService
    }
    
    func fetchDetail(for advertID: AdvertID, completion: (Advert?) -> Void) {
        advertService.fetchAdvert(for: advertID) { advert in
            completion(advert)
        }
    }
}
