//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

class MockCategoryService: CategoryService {

    var categories = [Core.Category]()

    func fetchCategories(completion: ([Core.Category]) -> Void) {
        completion(categories)
    }

    func fetchCategory(for categoryID: CategoryID, completion: (Core.Category?) -> Void) {
        let category = categories.first { category in
            category.categoryID == categoryID
        }
        completion(category)
    }
}
