//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitAppCoordinator {

    struct Dependencies {
        let advertService: AdvertService
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
            interactor: DiscoveryInteractor(advertService: deps.advertService, categoryService: deps.categoryService),
            listFormatter: DiscoveryListFormatter(),
            detailFormatter: DiscoveryDetailFormatter(),
            navigationWireframeFactory: UINavigationWireframeFactory(),
            discoveryListViewFactory: DiscoveryListViewControllerFactory(),
            detailViewFactory: DetailViewControllerFactory(),
            categorySelectionFeature: UICategorySelectionFeature(categoryService: deps.categoryService)
        )
        discoveryCoordinator = SplitDiscoveryCoordinator(dependencies: discoveryDeps)
        discoveryCoordinator?.start()
    }
}
