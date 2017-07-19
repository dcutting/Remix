//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SampleCategoryService: CategoryService {

    private let categories = [
        Category(categoryID: "1", parent: nil, children: ["2", "5"], title: "Bicycles"),
        Category(categoryID: "2", parent: "1", children: ["3", "4"], title: "Off road bikes"),
        Category(categoryID: "3", parent: "2", children: [], title: "Trail bikes"),
        Category(categoryID: "4", parent: "2", children: [], title: "Mountain bikes"),
        Category(categoryID: "5", parent: "1", children: [], title: "Racers"),
        Category(categoryID: "10", parent: nil, children: [], title: "Cars")
    ]

    func fetch(categoryID: CategoryID, completion: (Category?) -> Void) {
        let category = categories.first { category in
            category.categoryID == categoryID
        }
        completion(category)
    }

    func fetch(parentCategoryID: CategoryID?, completion: ([Category]) -> Void) {
        let filteredCategories = categories.filter { category in
            category.parent == parentCategoryID
        }
        completion(filteredCategories)
    }
}
