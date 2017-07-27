//  Copyright © 2017 cutting.io. All rights reserved.

import Entity
import Wireframe

protocol SplitDiscoveryFeature {
    func makeCoordinatorUsing(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator
}
