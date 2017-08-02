//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Utility
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

    func updateFilter(for groupID: GroupID?, completion: @escaping (AsyncResult<([Advert], [Group])>) -> Void) {
        filteredGroupID = groupID
        refetchFilteredAdverts(completion: completion)
    }

    func refetchFilteredAdverts(completion: @escaping (AsyncResult<([Advert], [Group])>) -> Void) {
        advertService.fetchAdverts { result in
            switch result {
            case let .success(adverts):
                self.groupService.fetchGroups { groups in
                    let filteredAdverts = self.filter(adverts: adverts, for: self.filteredGroupID)
                    completion(.success((filteredAdverts, groups)))
                }
            case .error:
                completion(.error)
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
