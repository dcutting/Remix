//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class AutoGroupInsertionInteractor {

    private let insertionInteractor: InsertionInteractor
    private let groupRecommendationService: GroupRecommendationService

    var draft: Draft {
        return insertionInteractor.draft
    }

    init(insertionInteractor: InsertionInteractor, groupRecommendationService: GroupRecommendationService) {
        self.insertionInteractor = insertionInteractor
        self.groupRecommendationService = groupRecommendationService
    }

    func update(title: String, completion: @escaping () -> Void) {
        insertionInteractor.update(title: title)
        groupRecommendationService.recommendGroup(for: title) { groupID in
            self.insertionInteractor.update(groupID: groupID)
            completion()
        }
    }

    func publish(completion: @escaping (AdvertID) -> Void) {
        insertionInteractor.publish(completion: completion)
    }
}
