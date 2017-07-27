//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

protocol AdvertListFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> AdvertListCoordinator
}
