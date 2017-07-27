//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

public protocol AdvertService {
    func fetchAdverts(completion: @escaping ([Advert]) -> Void)
    func fetchAdvert(for advertID: AdvertID, completion: @escaping (Advert?) -> Void)
}
