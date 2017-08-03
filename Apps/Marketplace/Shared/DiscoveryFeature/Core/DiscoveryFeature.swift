//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Service
import GroupSelectionFeature

class DiscoveryFeature {

    struct Dependencies {
        let navigationWireframeFactory: NavigationWireframeFactory
        let advertService: AdvertService
        let itemDetailViewFactory: ItemDetailViewFactory
        let advertListFeature: AdvertListFeature
        let groupSelectionFeature: GroupSelectionFeature
        let insertionFeature: InsertionFeature
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeNavigationDiscoveryCoordinator(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator {

        let featureDeps = NavigationDiscoveryFeature.Dependencies(
            advertService: deps.advertService,
            itemDetailViewFactory: deps.itemDetailViewFactory,
            advertListFeature: deps.advertListFeature,
            groupSelectionFeature: deps.groupSelectionFeature,
            insertionFeature: deps.insertionFeature
        )
        let feature = NavigationDiscoveryFeature(dependencies: featureDeps)

        return feature.makeCoordinator(navigationWireframe: navigationWireframe)
    }

    func makeSplitDiscoveryCoordinator(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator {

        let featureDeps = SplitDiscoveryFeature.Dependencies(
            navigationWireframeFactory: deps.navigationWireframeFactory,
            advertService: deps.advertService,
            itemDetailViewFactory: deps.itemDetailViewFactory,
            advertListFeature: deps.advertListFeature,
            groupSelectionFeature: deps.groupSelectionFeature,
            insertionFeature: deps.insertionFeature
        )
        let feature = SplitDiscoveryFeature(dependencies: featureDeps)

        return feature.makeCoordinator(splitWireframe: splitWireframe)
    }
}
