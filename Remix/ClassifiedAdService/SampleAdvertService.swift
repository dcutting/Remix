//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SampleAdvertService: AdvertService {

    let adverts = [
        Advert(advertID: "1", title: "Specialized", categoryID: "4"),
        Advert(advertID: "2", title: "Cervelo R2", categoryID: "5"),
        Advert(advertID: "3", title: "Fiat 500", categoryID: "10"),
        Advert(advertID: "4", title: "Apollo Jewel", categoryID: "4")
    ]

    func fetchAdverts(completion: ([Advert]) -> Void) {
        completion(adverts)
    }

    func fetchAdverts(for advertID: AdvertID, completion: (Advert?) -> Void) {
        let advert = adverts.first { advert in
            advert.advertID == advertID
        }
        completion(advert)
    }
}
