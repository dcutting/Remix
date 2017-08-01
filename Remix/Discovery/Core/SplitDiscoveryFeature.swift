//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Services
import GroupSelection

class SplitDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
        let advertListViewFactory: AdvertListViewFactory
        let itemDetailViewFactory: ItemDetailViewFactory
        let navigationWireframeFactory: NavigationWireframeFactory
        let groupSelectionFeature: GroupSelectionFeature
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
            advertListFeature: makeAdvertListFeature(),
            groupSelectionFeature: deps.groupSelectionFeature
        )
        return SplitDiscoveryCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService)
    }

    private func makeDetailFormatter() -> AdvertDetailFormatter {
        return AdvertDetailFormatter()
    }

    private func makeAdvertListFeature() -> AdvertListFeature {
        let featureDeps = AdvertListFeature.Dependencies(advertService: deps.advertService, groupService: deps.groupService, advertListViewFactory: deps.advertListViewFactory)
        return AdvertListFeature(dependencies: featureDeps)
    }
}
