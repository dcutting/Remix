//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class UINavigationDiscoveryFeature: NavigationDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let categoryService: CategoryService
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> NavigationDiscoveryCoordinator {
        let deps = NavigationDiscoveryCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: makeDetailViewFactory(),
            advertListFeature: makeAdvertListFeature(),
            categorySelectionFeature: makeCategorySelectionFeature()
        )
        return NavigationDiscoveryCoordinator(dependencies: deps)
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
