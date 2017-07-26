//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class NavigationAppCoordinator {

    private let navigationCoordinator = UINavigationCoordinator()
    private var discovery: NavigationDiscoveryCoordinator?

    init(window: UIWindow) {
        window.rootViewController = navigationCoordinator.viewController
    }

    func start() {
        let listFactory = DiscoveryListViewControllerFactory()
        let detailFactory = DetailViewControllerFactory()
        let dependencies = NavigationDiscoveryCoordinator.Dependencies(
            navigationCoordinator: navigationCoordinator,
            discoveryListViewFactory: listFactory,
            detailViewFactory: detailFactory,
            categorySelectionFeature: UICategorySelectionFeature()
        )
        discovery = NavigationDiscoveryCoordinator(dependencies: dependencies)
        discovery?.start()
    }
}
