//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategoryService {
    func fetchCategories(completion: ([Category]) -> Void)
    func fetchCategory(for categoryID: CategoryID, completion: (Category?) -> Void)
    func fetchCategories(withParentCategoryID: CategoryID?, completion: ([Category]) -> Void)
}
