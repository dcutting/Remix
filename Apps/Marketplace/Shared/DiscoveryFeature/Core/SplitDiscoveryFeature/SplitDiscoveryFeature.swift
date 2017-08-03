//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Service
import GroupSelectionFeature

class SplitDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let itemDetailViewFactory: ItemDetailViewFactory
        let navigationWireframeFactory: NavigationWireframeFactory
        let advertListFeature: AdvertListFeature
        let groupSelectionFeature: GroupSelectionFeature
        let insertionFeature: InsertionFeature
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator {
        let coordinatorDeps = SplitDiscoveryCoordinator.Dependencies(
            splitWireframe: splitWireframe,
            navigationWireframeFactory: deps.navigationWireframeFactory,
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: deps.itemDetailViewFactory,
            advertListFeature: deps.advertListFeature,
            groupSelectionFeature: deps.groupSelectionFeature,
            insertionFeature: deps.insertionFeature
        )
        return SplitDiscoveryCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService)
    }

    private func makeDetailFormatter() -> AdvertDetailFormatter {
        return AdvertDetailFormatter()
    }
}
