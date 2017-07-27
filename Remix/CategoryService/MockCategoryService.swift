//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class MockCategoryService: CategoryService {

    var categories = [Category]()

    func fetchCategories(completion: ([Category]) -> Void) {
        completion(categories)
    }

    func fetchCategory(for categoryID: CategoryID, completion: (Category?) -> Void) {
        let category = categories.first { category in
            category.categoryID == categoryID
        }
        completion(category)
    }
}
