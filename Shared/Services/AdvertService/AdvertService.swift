//  Copyright © 2017 cutting.io. All rights reserved.

import Utility
import Entity

public protocol AdvertService {
    func fetchAdverts(completion: @escaping (AsyncResult<[Advert]>) -> Void)
    func fetchAdvert(for advertID: AdvertID, completion: @escaping (AsyncResult<Advert>) -> Void)
    func publish(draft: Draft, completion: @escaping (AsyncResult<AdvertID>) -> Void)
}
