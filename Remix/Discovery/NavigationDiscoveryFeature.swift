//  Copyright © 2017 cutting.io. All rights reserved.

protocol NavigationDiscoveryFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator
}
