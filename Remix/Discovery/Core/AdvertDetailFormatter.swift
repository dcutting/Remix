//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

class AdvertDetailFormatter {
    func prepare(advert: Advert) -> ItemDetailViewData {
        return ItemDetailViewData(title: advert.title, detail: advert.description)
    }
}
