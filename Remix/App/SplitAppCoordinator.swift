//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitAppCoordinator {

    private let splitCoordinator = UISplitCoordinator()
    private let discoveryCoordinator: SplitDiscoveryCoordinator

    init(window: UIWindow) {
        window.rootViewController = splitCoordinator.viewController
        let dependencies = SplitDiscoveryCoordinator.Dependencies(
            splitCoordinator: splitCoordinator,
            navigationCoordinatorFactory: UINavigationCoordinatorFactory(),
            discoveryListViewFactory: DiscoveryListViewControllerFactory(),
            detailViewFactory: DetailViewControllerFactory(),
            categorySelectionFeature: UICategorySelectionFeature()
        )
        discoveryCoordinator = SplitDiscoveryCoordinator(dependencies: dependencies)
    }

    func start() {
        discoveryCoordinator.start()
    }
}
