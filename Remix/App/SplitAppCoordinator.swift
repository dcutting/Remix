//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitAppCoordinator {

    struct Dependencies {
        let categoryService: CategoryService
    }

    private let deps: Dependencies
    private let splitWireframe = UISplitWireframe()
    private var discoveryCoordinator: SplitDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = splitWireframe.viewController
    }

    func start() {
        let discoveryDeps = SplitDiscoveryCoordinator.Dependencies(
            splitWireframe: splitWireframe,
            navigationWireframeFactory: UINavigationWireframeFactory(),
            discoveryListViewFactory: DiscoveryListViewControllerFactory(),
            detailViewFactory: DetailViewControllerFactory(),
            categorySelectionFeature: UICategorySelectionFeature(categoryService: deps.categoryService)
        )
        discoveryCoordinator = SplitDiscoveryCoordinator(dependencies: discoveryDeps)
        discoveryCoordinator?.start()
    }
}
