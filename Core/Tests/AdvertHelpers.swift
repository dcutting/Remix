//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

func makeAdvert(advertID: AdvertID, title: String? = nil, categoryID: CategoryID? = nil) -> Advert {
    return Advert(advertID: advertID, title: title ?? "dummy title", categoryID: categoryID ?? "0")
}
