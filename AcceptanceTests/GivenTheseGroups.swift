//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity
import Services

let mockGroupService = MockGroupService()

@objc(GivenTheseGroups)
class GivenTheseGroups: NSObject {
    @objc var groupID: String?
    @objc var title: String?

    @objc func execute() {
        guard let groupID = groupID, let title = title else { return }
        let group = Group(groupID: groupID, parent: nil, children: [], title: title)
        mockGroupService.groups.append(group)
    }
}
