//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

public typealias AdvertID = String

public struct Advert {
    public let advertID: AdvertID
    public let title: String
    public let categoryID: CategoryID

    public init(advertID: AdvertID, title: String, categoryID: CategoryID) {
        self.advertID = advertID
        self.title = title
        self.categoryID = categoryID
    }
}

extension Advert: Equatable {
    public static func ==(lhs: Advert, rhs: Advert) -> Bool {
        return lhs.advertID == rhs.advertID &&
            lhs.title == rhs.title &&
            lhs.categoryID == rhs.categoryID
    }
}
