//  Copyright © 2017 cutting.io. All rights reserved.

import Core

protocol SplitDiscoveryFeature {
    func makeCoordinatorUsing(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator
}
