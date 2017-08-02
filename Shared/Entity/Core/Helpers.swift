//  Copyright © 2017 cutting.io. All rights reserved.

public func makeAdvert(advertID: AdvertID, title: String? = nil, description: String? = nil, groupID: GroupID? = nil) -> Advert {
    return Advert(advertID: advertID, title: title ?? "dummy title", description: description ?? "dummy description", groupID: groupID ?? "0")
}

public func makeGroup(groupID: GroupID, parent: GroupID? = nil, children: [GroupID] = [], title: String? = nil, description: String? = nil) -> Group {
    return Group(groupID: groupID, parent: parent, children: children, title: title ?? "dummy title", description: description ?? "dummy description")
}
