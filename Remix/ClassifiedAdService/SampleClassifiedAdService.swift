//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SampleClassifidAdService: ClassifiedAdService {

    func fetchClassifiedAds(completion: ([ClassifiedAd]) -> Void) {
        let classifieds = [
            ClassifiedAd(classifiedAdID: "1", title: "Specialized", category: "4"),
            ClassifiedAd(classifiedAdID: "2", title: "Cervelo R2", category: "5"),
            ClassifiedAd(classifiedAdID: "3", title: "Fiat 500", category: "10")
        ]
        completion(classifieds)
    }
}
