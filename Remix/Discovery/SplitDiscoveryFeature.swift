//  Copyright © 2017 cutting.io. All rights reserved.

protocol SplitDiscoveryFeature {
    func makeCoordinatorUsing(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator
}
