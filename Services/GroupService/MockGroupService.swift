//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Utility
import Entity

public class MockGroupService: GroupService {

    public var groups = [Group]()

    public init() {}

    public func fetchGroups(completion: @escaping (AsyncResult<[Group]>) -> Void) {
        completion(.success(groups))
    }

    public func fetchGroup(for groupID: GroupID, completion: @escaping (AsyncResult<Group>) -> Void) {
        let group = groups.first { group in
            group.groupID == groupID
        }
        if let group = group {
            completion(.success(group))
        } else {
            completion(.error)
        }
    }
}
