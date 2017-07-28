//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Wireframe
import Entity
import Services
import GroupSelection

class UISplitDiscoveryFeature: SplitDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
        let advertListViewFactory: AdvertListViewFactory
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator {
        let discoveryDeps = SplitDiscoveryCoordinator.Dependencies(
            splitWireframe: splitWireframe,
            navigationWireframeFactory: makeNavigationWireframeFactory(),
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: makeDetailViewFactory(),
            advertListFeature: makeAdvertListFeature(),
            groupSelectionFeature: makeGroupSelectionFeature()
        )
        return SplitDiscoveryCoordinator(dependencies: discoveryDeps)
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService)
    }

    private func makeDetailFormatter() -> DiscoveryDetailFormatter {
        return DiscoveryDetailFormatter()
    }

    private func makeNavigationWireframeFactory() -> NavigationWireframeFactory {
        return UINavigationWireframeFactory()
    }

    private func makeDetailViewFactory() -> AdvertDetailViewFactory {
        return AdvertDetailViewControllerFactory()
    }

    private func makeAdvertListFeature() -> AdvertListFeature {
        let featureDeps = AdvertListFeature.Dependencies(advertService: deps.advertService, groupService: deps.groupService, advertListViewFactory: deps.advertListViewFactory)
        return AdvertListFeature(dependencies: featureDeps)
    }

    private func makeGroupSelectionFeature() -> GroupSelectionFeature {
        let featureDeps = GroupSelectionFeature.Dependencies(groupService: deps.groupService, groupSelectionViewFactory: GroupSelectionViewControllerFactory())
        return GroupSelectionFeature(dependencies: featureDeps)
    }
}
