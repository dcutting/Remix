//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

func makeAdvert(advertID: AdvertID, categoryID: CategoryID) -> Advert {
    return Advert(advertID: advertID, title: "dummy title", categoryID: categoryID)
}
