//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

public class MockAdvertService: AdvertService {

    public var adverts = [Advert]()

    public init() {}

    public func fetchAdverts(completion: ([Advert]) -> Void) {
        completion(adverts)
    }

    public func fetchAdvert(for advertID: AdvertID, completion: (Advert?) -> Void) {
        let advert = adverts.first { advert in
            advert.advertID == advertID
        }
        completion(advert)
    }
}
