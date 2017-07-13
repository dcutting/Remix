//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    private(set) var selectedCategoryID: CategoryID?

    func update(selectedCategoryID: CategoryID?, completion: @escaping ([ClassifiedAd]) -> Void) {
        self.selectedCategoryID = selectedCategoryID
        completion([])
    }
}
