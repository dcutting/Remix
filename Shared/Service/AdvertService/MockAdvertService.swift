//  Copyright © 2017 cutting.io. All rights reserved.

import Utility
import Entity

public class MockAdvertService: AdvertService {

    public var adverts = [Advert]()

    public init() {}

    public func fetchAdverts(completion: @escaping (AsyncResult<[Advert]>) -> Void) {
        completion(.success(adverts))
    }

    public func fetchAdvert(for advertID: AdvertID, completion: @escaping (AsyncResult<Advert>) -> Void) {
        let advert = adverts.first { advert in
            advert.advertID == advertID
        }
        if let advert = advert {
            completion(.success(advert))
        } else {
            completion(.error)
        }
    }

    public func publish(draft: Draft, completion: @escaping (AsyncResult<AdvertID>) -> Void) {

        guard let groupID = draft.groupID else {
            completion(.error)
            return
        }

        let advertID = "\(UUID())"
        let title = draft.title ?? "<untitled>"
        let description = ""

        let advert = Advert(advertID: advertID, title: title, description: description, groupID: groupID)
        adverts.append(advert)
        
        completion(.success(advertID))
    }
}
