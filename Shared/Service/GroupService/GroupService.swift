//  Copyright © 2017 cutting.io. All rights reserved.

import Utility
import Entity

public protocol GroupService {
    func fetchGroups(completion: @escaping (AsyncResult<[Group]>) -> Void)
    func fetchGroup(for groupID: GroupID, completion: @escaping (AsyncResult<Group>) -> Void)
}
