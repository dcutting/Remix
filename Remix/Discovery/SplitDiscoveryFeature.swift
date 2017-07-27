//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

protocol SplitDiscoveryFeature {
    func makeCoordinatorUsing(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator
}
