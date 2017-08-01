//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class InsertionInteractor {

    var draft = Draft()

    func update(title: String) {
        draft.title = title
    }

    func update(groupID: GroupID) {
        draft.groupID = groupID
    }
}
