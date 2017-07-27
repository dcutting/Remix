//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Core

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
        let discoveryDeps = UISplitDiscoveryFeature.Dependencies(advertService: deps.advertService, groupService: deps.groupService)
        return UISplitDiscoveryFeature(dependencies: discoveryDeps)
    }
}
