//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SampleClassifiedAdService: ClassifiedAdService {

    let classifieds = [
        ClassifiedAd(classifiedAdID: "1", title: "Specialized", category: "4"),
        ClassifiedAd(classifiedAdID: "2", title: "Cervelo R2", category: "5"),
        ClassifiedAd(classifiedAdID: "3", title: "Fiat 500", category: "10"),
        ClassifiedAd(classifiedAdID: "4", title: "Apollo Jewel", category: "4")
    ]

    func fetchClassifiedAds(completion: ([ClassifiedAd]) -> Void) {
        completion(classifieds)
    }

    func fetchClassifiedAd(for classifiedAdID: ClassifiedAdID, completion: (ClassifiedAd?) -> Void) {
        let classifiedAd = classifieds.first { classifiedAd in
            classifiedAd.classifiedAdID == classifiedAdID
        }
        completion(classifiedAd)
    }
}
