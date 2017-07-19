//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategoryService {
    func fetch(parentCategoryID: CategoryID?, completion: ([Category]) -> Void)
}
