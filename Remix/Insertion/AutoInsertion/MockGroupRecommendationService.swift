//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class MockGroupRecommendationService: GroupRecommendationService {

    var mappings = [(String, GroupID)]()
    let defaultGroupID: GroupID

    init(defaultGroupID: GroupID) {
        self.defaultGroupID = defaultGroupID
    }

    func recommendGroup(for text: String, completion: @escaping (GroupID) -> Void) {

        let firstMapping = mappings.first { (key, groupID) in
            text.lowercased().contains(key.lowercased())
        }

        if let (_, groupID) = firstMapping {
            completion(groupID)
        } else {
            completion(defaultGroupID)
        }
    }
}
