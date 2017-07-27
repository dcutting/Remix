//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

public protocol GroupService {
    func fetchGroups(completion: @escaping ([Group]) -> Void)
    func fetchGroup(for groupID: GroupID, completion: @escaping (Group?) -> Void)
}
