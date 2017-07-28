//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Services
import GroupSelection

class NavigationDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
        let advertListViewFactory: AdvertListViewFactory
        let advertDetailViewFactory: AdvertDetailViewFactory
        let groupSelectionFeature: GroupSelectionFeature
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator {
        let coordinatorDeps = NavigationDiscoveryCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: deps.advertDetailViewFactory,
            advertListFeature: makeAdvertListFeature(),
            groupSelectionFeature: deps.groupSelectionFeature
        )
        return NavigationDiscoveryCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService)
    }

    private func makeDetailFormatter() -> DiscoveryDetailFormatter {
        return DiscoveryDetailFormatter()
    }

    private func makeAdvertListFeature() -> AdvertListFeature {
        let featureDeps = AdvertListFeature.Dependencies(advertService: deps.advertService, groupService: deps.groupService, advertListViewFactory: deps.advertListViewFactory)
        return AdvertListFeature(dependencies: featureDeps)
    }
}
