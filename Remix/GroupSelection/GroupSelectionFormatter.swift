//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

class GroupSelectionFormatter {

    func prepare(groups: [Group]) -> GroupSelectionViewData {
        let items = groups.map { group -> GroupSelectionViewDataItem in
            let hasChildren = !group.children.isEmpty
            return GroupSelectionViewDataItem(groupID: group.groupID, title: group.title, hasChildren: hasChildren)
        }
        return GroupSelectionViewData(title: "Select group", items: items)
    }
}
