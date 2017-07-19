//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CategorySelectionInteractor {

    func fetchCategories(parentCategoryID: CategoryID?, completion: ([Category]) -> Void) {
        SampleCategoryService().fetch(parentCategoryID: parentCategoryID) { categories in
            completion(categories)
        }
    }
}
