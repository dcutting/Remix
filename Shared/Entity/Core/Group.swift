//  Copyright © 2017 cutting.io. All rights reserved.

public typealias GroupID = String

public struct Group {

    public let groupID: GroupID
    public let parent: GroupID?
    public let children: [GroupID]
    public let title: String
    public let description: String

    public init(groupID: GroupID, parent: GroupID?, children: [GroupID], title: String, description: String) {
        self.groupID = groupID
        self.parent = parent
        self.children = children
        self.title = title
        self.description = description
    }
}

extension Group: Equatable {
    
    public static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.groupID == rhs.groupID &&
            lhs.parent == rhs.parent &&
            lhs.children == rhs.children &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description
    }
}
