//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class AdvertListInteractor {
    
    let advertService: AdvertService
    let groupService: GroupService

    init(advertService: AdvertService, groupService: GroupService) {
        self.advertService = advertService
        self.groupService = groupService
    }

    func update(for groupID: GroupID?, completion: @escaping ([Advert], [Group]) -> Void) {
        advertService.fetchAdverts { adverts in
            groupService.fetchGroups { groups in
                let filteredAdverts = filter(adverts: adverts, for: groupID)
                completion(filteredAdverts, groups)
            }
        }
    }

    private func filter(adverts: [Advert], for groupID: GroupID?) -> [Advert] {
        guard let groupID = groupID else { return adverts }
        let filteredAdverts = adverts.filter { advert in
            advert.groupID == groupID
        }
        return filteredAdverts
    }
}
