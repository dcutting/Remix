//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity
import Services

class AdvertListInteractor {
    
    let advertService: AdvertService
    let groupService: GroupService

    private var filteredGroupID: GroupID?

    init(advertService: AdvertService, groupService: GroupService) {
        self.advertService = advertService
        self.groupService = groupService
    }

    func updateFilter(for groupID: GroupID?, completion: @escaping ([Advert], [Group]) -> Void) {
        filteredGroupID = groupID
        refetchFilteredAdverts(completion: completion)
    }

    func refetchFilteredAdverts(completion: @escaping ([Advert], [Group]) -> Void) {
        advertService.fetchAdverts { adverts in
            self.groupService.fetchGroups { groups in
                let filteredAdverts = self.filter(adverts: adverts, for: self.filteredGroupID)
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
