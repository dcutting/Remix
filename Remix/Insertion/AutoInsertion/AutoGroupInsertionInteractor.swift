//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class AutoGroupInsertionInteractor {

    private let insertionInteractor: InsertionInteractor
    private let groupRecommendationService: GroupRecommendationService

    init(insertionInteractor: InsertionInteractor, groupRecommendationService: GroupRecommendationService) {
        self.insertionInteractor = insertionInteractor
        self.groupRecommendationService = groupRecommendationService
    }

    func update(title: String) {
        insertionInteractor.update(title: title)
        groupRecommendationService.recommendGroup(for: title) { groupID in
            self.insertionInteractor.update(groupID: groupID)
        }
    }

    func publish(completion: @escaping (AdvertID) -> Void) {
        insertionInteractor.publish(completion: completion)
    }
}
