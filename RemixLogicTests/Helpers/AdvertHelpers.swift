//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

func makeAdvert(advertID: AdvertID, title: String? = nil, categoryID: CategoryID) -> Advert {
    return Advert(advertID: advertID, title: title ?? "dummy title", categoryID: categoryID)
}
