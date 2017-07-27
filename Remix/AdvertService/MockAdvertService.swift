//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class MockAdvertService: AdvertService {

    var adverts = [Advert]()

    func fetchAdverts(completion: ([Advert]) -> Void) {
        completion(adverts)
    }

    func fetchAdvert(for advertID: AdvertID, completion: (Advert?) -> Void) {
        let advert = adverts.first { advert in
            advert.advertID == advertID
        }
        completion(advert)
    }
}
