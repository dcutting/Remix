//  Copyright © 2017 cutting.io. All rights reserved.

import Entity

class MockGroupRecommendationService: GroupRecommendationService {

    var mappings = [(String, GroupID)]()
    let defaultGroupID: GroupID

    init(defaultGroupID: GroupID) {
        self.defaultGroupID = defaultGroupID
    }

    func recommendGroup(for text: String, completion: @escaping (GroupID) -> Void) {

        let groupID = findBestMatch(for: text)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(groupID)
        }
    }

    private func findBestMatch(for text: String) -> GroupID {
        let firstMapping = mappings.first { (key, groupID) in
            text.lowercased().contains(key.lowercased())
        }

        guard let (_, groupID) = firstMapping else { return defaultGroupID }
        return groupID
    }
}
