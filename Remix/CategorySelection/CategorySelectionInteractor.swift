//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CategorySelectionInteractor {

    let categoryService: CategoryService = SampleCategoryService()

    enum SelectionType {
        case leafCategory
        case parentCategory
    }

    func findSelectionType(for categoryID: CategoryID, completion: (SelectionType) -> Void) {
        categoryService.fetch(categoryID: categoryID) { category in
            guard let category = category else { preconditionFailure() }
            let type: SelectionType = category.children.isEmpty ? .leafCategory : .parentCategory
            completion(type)
        }
    }

    func fetchCategories(parentCategoryID: CategoryID?, completion: ([Category]) -> Void) {
        categoryService.fetch(parentCategoryID: parentCategoryID) { categories in
            completion(categories)
        }
    }
}
