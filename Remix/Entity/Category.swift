//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

typealias CategoryID = String

struct Category {
    let categoryID: CategoryID
    let parent: CategoryID?
    let children: [CategoryID]
    let title: String
}
