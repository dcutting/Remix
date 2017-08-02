//  Copyright © 2017 cutting.io. All rights reserved.

import Entity

class GroupSelectionFormatter {

    func prepare(groups: [Group]) -> GroupSelectionViewData {
        let items = groups.map(makeItem)
        return GroupSelectionViewData(title: "Select group", items: items)
    }

    private func makeItem(for group: Group) -> GroupSelectionViewDataItem {
        let hasChildren = !group.children.isEmpty
        return GroupSelectionViewDataItem(groupID: group.groupID, title: group.title, hasChildren: hasChildren)
    }
}
