//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

class DiscoveryInteractor {

    let advertService: AdvertService

    init(advertService: AdvertService) {
        self.advertService = advertService
    }
    
    func fetchDetail(for advertID: AdvertID, completion: (Advert?) -> Void) {
        advertService.fetchAdvert(for: advertID) { advert in
            completion(advert)
        }
    }
}
