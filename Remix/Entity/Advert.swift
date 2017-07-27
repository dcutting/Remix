//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

typealias AdvertID = String

struct Advert {
    let advertID: AdvertID
    let title: String
    let categoryID: CategoryID
}

extension Advert: Equatable {
    static func ==(lhs: Advert, rhs: Advert) -> Bool {
        return lhs.advertID == rhs.advertID &&
            lhs.title == rhs.title &&
            lhs.categoryID == rhs.categoryID
    }
}
