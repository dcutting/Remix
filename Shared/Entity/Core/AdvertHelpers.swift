//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

public func makeAdvert(advertID: AdvertID, title: String? = nil, description: String? = nil, groupID: GroupID? = nil) -> Advert {
    return Advert(advertID: advertID, title: title ?? "dummy title", description: description ?? "dummy description", groupID: groupID ?? "0")
}
