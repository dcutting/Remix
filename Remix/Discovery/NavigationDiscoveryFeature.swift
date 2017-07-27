//  Copyright © 2017 cutting.io. All rights reserved.

import Core

protocol NavigationDiscoveryFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator
}
