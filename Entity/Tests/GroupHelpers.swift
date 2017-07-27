//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

public func makeGroup(groupID: GroupID, parent: GroupID? = nil, children: [GroupID] = [], title: String? = nil) -> Group {
    return Group(groupID: groupID, parent: parent, children: children, title: title ?? "dummy title")
}
