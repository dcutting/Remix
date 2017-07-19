//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategoryService {
    func fetch(categoryID: CategoryID, completion: (Category?) -> Void)
    func fetch(parentCategoryID: CategoryID?, completion: ([Category]) -> Void)
}
