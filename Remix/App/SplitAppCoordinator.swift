//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitAppCoordinator {

    struct Dependencies {
        let categoryService: CategoryService
    }

    private let deps: Dependencies
    private let splitCoordinator = UISplitCoordinator()
    private var discoveryCoordinator: SplitDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = splitCoordinator.viewController
    }

    func start() {
        let discoveryDeps = SplitDiscoveryCoordinator.Dependencies(
            splitCoordinator: splitCoordinator,
            navigationCoordinatorFactory: UINavigationCoordinatorFactory(),
            discoveryListViewFactory: DiscoveryListViewControllerFactory(),
            detailViewFactory: DetailViewControllerFactory(),
            categorySelectionFeature: UICategorySelectionFeature(categoryService: deps.categoryService)
        )
        discoveryCoordinator = SplitDiscoveryCoordinator(dependencies: discoveryDeps)
        discoveryCoordinator?.start()
    }
}
