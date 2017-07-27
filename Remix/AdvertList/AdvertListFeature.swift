//  Copyright © 2017 cutting.io. All rights reserved.

import Entity
import Wireframe

protocol AdvertListFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> AdvertListCoordinator
}
