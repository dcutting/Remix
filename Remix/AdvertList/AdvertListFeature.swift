//  Copyright © 2017 cutting.io. All rights reserved.

import Core

protocol AdvertListFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> AdvertListCoordinator
}
