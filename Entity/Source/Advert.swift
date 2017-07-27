//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

public typealias AdvertID = String

public struct Advert {
    public let advertID: AdvertID
    public let title: String
    public let groupID: GroupID

    public init(advertID: AdvertID, title: String, groupID: GroupID) {
        self.advertID = advertID
        self.title = title
        self.groupID = groupID
    }
}

extension Advert: Equatable {
    public static func ==(lhs: Advert, rhs: Advert) -> Bool {
        return lhs.advertID == rhs.advertID &&
            lhs.title == rhs.title &&
            lhs.groupID == rhs.groupID
    }
}
