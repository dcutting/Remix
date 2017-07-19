//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryInteractor {

    private(set) var selectedCategoryID: CategoryID?

    func update(selectedCategoryID: CategoryID?, completion: @escaping ([ClassifiedAd]) -> Void) {
        self.selectedCategoryID = selectedCategoryID
        let classifieds = [
            ClassifiedAd(classifiedAdID: "1", title: "Shiny bike", category: "5"),
            ClassifiedAd(classifiedAdID: "2", title: "Rusty bike", category: "5"),
            ClassifiedAd(classifiedAdID: "3", title: "Nine inch nails", category: "7")
        ]
        completion(classifieds)
    }
}
