//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CategorySelectionInteractor {

    enum SelectionType {
        case leafCategory
        case parentCategory
        case notFound
    }

    let categoryService: CategoryService

    init(categoryService: CategoryService) {
        self.categoryService = categoryService
    }

    func findSelectionType(for categoryID: CategoryID, completion: (SelectionType) -> Void) {
        categoryService.fetchCategory(for: categoryID) { category in
            guard let category = category else {
                completion(.notFound)
                return
            }
            let type: SelectionType = category.children.isEmpty ? .leafCategory : .parentCategory
            completion(type)
        }
    }

    func fetchCategories(parentCategoryID: CategoryID?, completion: ([Category]) -> Void) {
        categoryService.fetchCategories(withParentCategoryID: parentCategoryID) { categories in
            completion(categories)
        }
    }
}
