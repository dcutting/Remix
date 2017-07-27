//  Copyright © 2017 cutting.io. All rights reserved.

import Entity
import Wireframe

protocol NavigationDiscoveryFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator
}
