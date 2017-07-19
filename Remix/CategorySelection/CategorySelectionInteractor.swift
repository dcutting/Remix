//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CategorySelectionInteractor {

    let categoryService: CategoryService = SampleCategoryService()

    enum SelectionType {
        case leafCategory
        case parentCategory
    }

    func selectionType(for categoryID: CategoryID, completion: (SelectionType) -> Void) {
        categoryService.fetch(categoryID: categoryID) { category in
            guard let category = category else { preconditionFailure() }
            if category.children.isEmpty {
                completion(.leafCategory)
            } else {
                completion(.parentCategory)
            }
        }
    }

    func fetchCategories(parentCategoryID: CategoryID?, completion: ([Category]) -> Void) {
        categoryService.fetch(parentCategoryID: parentCategoryID) { categories in
            completion(categories)
        }
    }
}
