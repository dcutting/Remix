//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class UINavigationDiscoveryFeature: NavigationDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator {
        let deps = NavigationDiscoveryCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: makeDetailViewFactory(),
            advertListFeature: makeAdvertListFeature(),
            groupSelectionFeature: makeGroupSelectionFeature()
        )
        return NavigationDiscoveryCoordinator(dependencies: deps)
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService)
    }

    private func makeDetailFormatter() -> DiscoveryDetailFormatter {
        return DiscoveryDetailFormatter()
    }

    private func makeDetailViewFactory() -> AdvertDetailViewFactory {
        return AdvertDetailViewControllerFactory()
    }

    private func makeAdvertListFeature() -> AdvertListFeature {
        let featureDeps = UIAdvertListFeature.Dependencies(advertService: deps.advertService, groupService: deps.groupService)
        return UIAdvertListFeature(dependencies: featureDeps)
    }

    private func makeGroupSelectionFeature() -> GroupSelectionFeature {
        let featureDeps = UIGroupSelectionFeature.Dependencies(groupService: deps.groupService)
        return UIGroupSelectionFeature(dependencies: featureDeps)
    }
}
