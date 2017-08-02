//  Copyright © 2017 cutting.io. All rights reserved.

import Entity

class GroupDetailFormatter {
    func prepare(group: Group) -> ItemDetailViewData {
        return ItemDetailViewData(title: group.title, detail: group.description)
    }
}
