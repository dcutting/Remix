//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class NavigationAppCoordinator {

    struct Dependencies {
        let categoryService: CategoryService
    }

    private let deps: Dependencies
    private let navigationCoordinator = UINavigationCoordinator()
    private var discoveryCoordinator: NavigationDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = navigationCoordinator.viewController
    }

    func start() {
        let listFactory = DiscoveryListViewControllerFactory()
        let detailFactory = DetailViewControllerFactory()
        let dependencies = NavigationDiscoveryCoordinator.Dependencies(
            navigationCoordinator: navigationCoordinator,
            discoveryListViewFactory: listFactory,
            detailViewFactory: detailFactory,
            categorySelectionFeature: UICategorySelectionFeature(categoryService: deps.categoryService)
        )
        discoveryCoordinator = NavigationDiscoveryCoordinator(dependencies: dependencies)
        discoveryCoordinator?.start()
    }
}
