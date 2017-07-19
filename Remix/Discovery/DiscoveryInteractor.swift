//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    private(set) var selectedCategoryID: CategoryID?

    func update(selectedCategoryID: CategoryID?, completion: @escaping ([ClassifiedAd]) -> Void) {
        self.selectedCategoryID = selectedCategoryID
        let classifieds = [
            ClassifiedAd(classifiedAdID: "1", title: "Shiny mountain bike", category: "2"),
            ClassifiedAd(classifiedAdID: "2", title: "Rusty racing bike", category: "3"),
            ClassifiedAd(classifiedAdID: "3", title: "Fiat 500", category: "4")
        ]
        completion(classifieds)
    }
}
