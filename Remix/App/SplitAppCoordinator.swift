//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Wireframe
import Entity
import Services
import GroupSelection

class SplitAppCoordinator {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
    }

    private let deps: Dependencies
    private let splitWireframe = UISplitWireframe()
    private var discoveryCoordinator: SplitDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = splitWireframe.viewController
    }

    func start() {
        let feature = makeFeature()
        let coordinator = feature.makeCoordinatorUsing(splitWireframe: splitWireframe)
        discoveryCoordinator = coordinator
        coordinator.start()
    }

    private func makeFeature() -> SplitDiscoveryFeature {
        let discoveryDeps = SplitDiscoveryFeature.Dependencies(
            advertService: deps.advertService,
            groupService: deps.groupService,
            advertListViewFactory: AdvertListViewControllerFactory(),
            itemDetailViewFactory: ItemDetailViewControllerFactory(),
            navigationWireframeFactory: UINavigationWireframeFactory(),
            groupSelectionFeature: makeGroupSelectionFeature()
        )
        return SplitDiscoveryFeature(dependencies: discoveryDeps)
    }

    private func makeGroupSelectionFeature() -> GroupSelectionFeature {
        let featureDeps = GroupSelectionFeature.Dependencies(groupService: deps.groupService, groupSelectionViewFactory: GroupSelectionViewControllerFactory())
        return GroupSelectionFeature(dependencies: featureDeps)
    }
}
