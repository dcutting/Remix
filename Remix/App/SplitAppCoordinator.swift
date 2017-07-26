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
            navigationWireframeFactory: makeNavigationWireframeFactory(),
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: makeDetailViewFactory(),
            advertListFeature: makeAdvertListFeature(),
            categorySelectionFeature: makeCategorySelectionFeature()
        )
        discoveryCoordinator = SplitDiscoveryCoordinator(dependencies: discoveryDeps)
        discoveryCoordinator?.start()
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService, categoryService: deps.categoryService)
    }

    private func makeDetailFormatter() -> DiscoveryDetailFormatter {
        return DiscoveryDetailFormatter()
    }

    private func makeNavigationWireframeFactory() -> NavigationWireframeFactory {
        return UINavigationWireframeFactory()
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
