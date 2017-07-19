//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol ClassifiedAdService {
    func fetchClassifiedAds(completion: ([ClassifiedAd]) -> Void)
    func fetchClassifiedAd(for classifiedAdID: ClassifiedAdID, completion: (ClassifiedAd?) -> Void)
}
