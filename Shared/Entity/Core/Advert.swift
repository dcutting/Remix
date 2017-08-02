//  Copyright © 2017 cutting.io. All rights reserved.

public typealias AdvertID = String

public struct Advert {

    public let advertID: AdvertID
    public let title: String
    public let description: String
    public let groupID: GroupID

    public init(advertID: AdvertID, title: String, description: String, groupID: GroupID) {
        self.advertID = advertID
        self.title = title
        self.description = description
        self.groupID = groupID
    }
}

extension Advert: Equatable {

    public static func ==(lhs: Advert, rhs: Advert) -> Bool {
        return lhs.advertID == rhs.advertID &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.groupID == rhs.groupID
    }
}
