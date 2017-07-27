//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class MockGroupService: GroupService {

    var groups = [Group]()

    func fetchGroups(completion: ([Group]) -> Void) {
        completion(groups)
    }

    func fetchGroup(for groupID: GroupID, completion: (Group?) -> Void) {
        let group = groups.first { group in
            group.groupID == groupID
        }
        completion(group)
    }
}
