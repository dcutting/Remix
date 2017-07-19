//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {
    
    private(set) var selectedCategoryID: CategoryID?
    
    func update(selectedCategoryID: CategoryID?, completion: @escaping ([ClassifiedAd]) -> Void) {
        self.selectedCategoryID = selectedCategoryID
        SampleClassifidAdService().fetchClassifiedAds { classifiedAds in
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
}
