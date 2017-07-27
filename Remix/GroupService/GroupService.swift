//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

protocol GroupService {
    func fetchGroups(completion: ([Group]) -> Void)
    func fetchGroup(for groupID: GroupID, completion: (Group?) -> Void)
}
