//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

protocol CategoryService {
    func fetchCategories(completion: ([Core.Category]) -> Void)
    func fetchCategory(for categoryID: CategoryID, completion: (Core.Category?) -> Void)
}
