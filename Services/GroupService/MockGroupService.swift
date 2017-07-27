//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

public class MockGroupService: GroupService {

    public var groups = [Group]()

    public init() {}

    public func fetchGroups(completion: @escaping ([Group]) -> Void) {
        completion(groups)
    }

    public func fetchGroup(for groupID: GroupID, completion: @escaping (Group?) -> Void) {
        let group = groups.first { group in
            group.groupID == groupID
        }
        completion(group)
    }
}
