//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Service
import GroupSelectionFeature

class NavigationDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let itemDetailViewFactory: ItemDetailViewFactory
        let advertListFeature: AdvertListFeature
        let insertionFeature: InsertionFeature
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
            detailViewFactory: deps.itemDetailViewFactory,
            advertListFeature: deps.advertListFeature,
            insertionFeature: deps.insertionFeature,
            groupSelectionFeature: deps.groupSelectionFeature
        )
        return NavigationDiscoveryCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService)
    }

    private func makeDetailFormatter() -> AdvertDetailFormatter {
        return AdvertDetailFormatter()
    }
}
