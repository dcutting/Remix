//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class NavigationAppCoordinator {

    struct Dependencies {
        let advertService: AdvertService
        let categoryService: CategoryService
    }

    private let deps: Dependencies
    private let navigationWireframe = UINavigationWireframe()
    private var discoveryCoordinator: NavigationDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = navigationWireframe.viewController
    }

    func start() {
        let listFactory = DiscoveryListViewControllerFactory()
        let detailFactory = DetailViewControllerFactory()
        let dependencies = NavigationDiscoveryCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            interactor: DiscoveryInteractor(advertService: deps.advertService, categoryService: deps.categoryService),
            listFormatter: DiscoveryListFormatter(),
            detailFormatter: DiscoveryDetailFormatter(),
            discoveryListViewFactory: listFactory,
            detailViewFactory: detailFactory,
            categorySelectionFeature: UICategorySelectionFeature(categoryService: deps.categoryService)
        )
        discoveryCoordinator = NavigationDiscoveryCoordinator(dependencies: dependencies)
        discoveryCoordinator?.start()
    }
}
