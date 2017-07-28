//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity
import Services

public let mockAdvertService = MockAdvertService()

@objc(GivenTheseAdverts)
class GivenTheseAdverts: NSObject {

    @objc var advertID: String?
    @objc var title: String?
    @objc var groupID: String?

    @objc func execute() {
        guard let advertID = advertID, let title = title, let groupID = groupID else { return }
        let advert = Advert(advertID: advertID, title: title, groupID: groupID)
        mockAdvertService.adverts.append(advert)
    }
}
