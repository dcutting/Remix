//  Copyright © 2017 cutting.io. All rights reserved.

import Utility
import Entity
import Service

class DiscoveryInteractor {

    let advertService: AdvertService

    init(advertService: AdvertService) {
        self.advertService = advertService
    }
    
    func fetchDetail(for advertID: AdvertID, completion: @escaping (AsyncResult<Advert>) -> Void) {
        advertService.fetchAdvert(for: advertID) { result in
            completion(result)
        }
    }
}
