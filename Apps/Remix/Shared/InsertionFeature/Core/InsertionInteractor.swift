//  Copyright © 2017 cutting.io. All rights reserved.

import Utility
import Entity
import Services

class InsertionInteractor {

    private let advertService: AdvertService

    private(set) var draft = Draft()

    init(advertService: AdvertService) {
        self.advertService = advertService
    }

    func update(title: String) {
        draft.title = title
    }

    func update(groupID: GroupID) {
        draft.groupID = groupID
    }

    func publish(completion: @escaping (AsyncResult<AdvertID>) -> Void) {
        advertService.publish(draft: draft) { result in
            completion(result)
        }
    }
}
