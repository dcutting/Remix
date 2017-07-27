//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

protocol NavigationDiscoveryFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator
}
