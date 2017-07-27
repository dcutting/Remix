//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

class AdvertListFormatter {

    func prepare(adverts: [Advert], groups: [Group]) -> AdvertListViewData {
        let items = adverts.map { advert in
            makeItem(from: advert, groups: groups)
        }
        return AdvertListViewData(items: items)
    }

    private func makeItem(from advert: Advert, groups: [Group]) -> AdvertListViewDataItem {
        let groupName = name(for: advert.groupID, groups: groups)
        return AdvertListViewDataItem(advertID: advert.advertID, title: advert.title, group: groupName)
    }

    private func name(for groupID: GroupID, groups: [Group]) -> String {
        let group = groups.first { group in
            group.groupID == groupID
        }
        let groupName = group?.title ?? ""
        return groupName
    }
}
