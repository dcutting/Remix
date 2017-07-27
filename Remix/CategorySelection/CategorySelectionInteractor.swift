//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

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

    func fetchCategories(parentCategoryID: CategoryID?, completion: ([Core.Category]) -> Void) {
        categoryService.fetchCategories() { categories in
            let filteredCategories = filter(categories: categories, withParentCategoryID: parentCategoryID)
            completion(filteredCategories)
        }
    }

    private func filter(categories: [Core.Category], withParentCategoryID parentCategoryID: CategoryID?) -> [Core.Category] {
        let filteredCategories = categories.filter { category in
            category.parent == parentCategoryID
        }
        return filteredCategories
    }
}
