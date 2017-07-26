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
        let dependencies = NavigationDiscoveryCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: makeDetailViewFactory(),
            advertListFeature: makeAdvertListFeature(),
            categorySelectionFeature: makeCategorySelectionFeature()
        )
        discoveryCoordinator = NavigationDiscoveryCoordinator(dependencies: dependencies)
        discoveryCoordinator?.start()
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService, categoryService: deps.categoryService)
    }

    private func makeDetailFormatter() -> DiscoveryDetailFormatter {
        return DiscoveryDetailFormatter()
    }

    private func makeDetailViewFactory() -> AdvertDetailViewFactory {
        return AdvertDetailViewControllerFactory()
    }

    private func makeAdvertListFeature() -> AdvertListFeature {
        return UIAdvertListFeature(advertService: deps.advertService, categoryService: deps.categoryService)
    }

    private func makeCategorySelectionFeature() -> CategorySelectionFeature {
        return UICategorySelectionFeature(categoryService: deps.categoryService)
    }
}
