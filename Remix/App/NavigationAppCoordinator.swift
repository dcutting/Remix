//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class NavigationAppCoordinator {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
    }

    private let deps: Dependencies
    private let navigationWireframe = UINavigationWireframe()
    private var discoveryCoordinator: NavigationDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = navigationWireframe.viewController
    }

    func start() {
        let feature = makeFeature()
        let coordinator = feature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
        discoveryCoordinator = coordinator
        coordinator.start()
    }

    private func makeFeature() -> NavigationDiscoveryFeature {
        let discoveryDeps = UINavigationDiscoveryFeature.Dependencies(advertService: deps.advertService, groupService: deps.groupService)
        return UINavigationDiscoveryFeature(dependencies: discoveryDeps)
    }
}
