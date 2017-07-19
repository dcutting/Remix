//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    let classifiedAdService: ClassifiedAdService = SampleClassifiedAdService()
    
    func update(selectedCategoryID: CategoryID?, completion: @escaping ([ClassifiedAd]) -> Void) {
        classifiedAdService.fetchClassifiedAds { classifiedAds in
            if let selected = selectedCategoryID {
                let filteredAds = classifiedAds.filter { ad in
                    ad.category == selected
                }
                completion(filteredAds)
            } else {
                completion(classifiedAds)
            }
        }
    }

    func fetchDetail(for classifiedAdID: ClassifiedAdID, completion: (ClassifiedAd?) -> Void) {
        classifiedAdService.fetchClassifiedAd(for: classifiedAdID) { classifiedAd in
            completion(classifiedAd)
        }
    }
}
