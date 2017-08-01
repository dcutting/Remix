//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

public class MockAdvertService: AdvertService {

    public var adverts = [Advert]()

    public init() {}

    public func fetchAdverts(completion: @escaping ([Advert]) -> Void) {
        completion(adverts)
    }

    public func fetchAdvert(for advertID: AdvertID, completion: @escaping (Advert?) -> Void) {
        let advert = adverts.first { advert in
            advert.advertID == advertID
        }
        completion(advert)
    }

    public func publish(draft: Draft, completion: @escaping (AdvertID) -> Void) {
        let advertID = "\(UUID())"
        let title = draft.title ?? "<untitled>"
        let description = ""
        guard let groupID = draft.groupID else { preconditionFailure("No group set on draft") }
        let advert = Advert(advertID: advertID, title: title, description: description, groupID: groupID)
        adverts.append(advert)
        completion(advertID)
    }
}
