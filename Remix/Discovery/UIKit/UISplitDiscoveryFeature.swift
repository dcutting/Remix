//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class UISplitDiscoveryFeature: SplitDiscoveryFeature {

    struct Dependencies {
        let advertService: AdvertService
        let categoryService: CategoryService
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(splitWireframe: SplitWireframe) -> SplitDiscoveryCoordinator {
        let discoveryDeps = SplitDiscoveryCoordinator.Dependencies(
            splitWireframe: splitWireframe,
            navigationWireframeFactory: makeNavigationWireframeFactory(),
            interactor: makeInteractor(),
            detailFormatter: makeDetailFormatter(),
            detailViewFactory: makeDetailViewFactory(),
            advertListFeature: makeAdvertListFeature(),
            categorySelectionFeature: makeCategorySelectionFeature()
        )
        return SplitDiscoveryCoordinator(dependencies: discoveryDeps)
    }

    private func makeInteractor() -> DiscoveryInteractor {
        return DiscoveryInteractor(advertService: deps.advertService)
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
        let featureDeps = UIAdvertListFeature.Dependencies(advertService: deps.advertService, categoryService: deps.categoryService)
        return UIAdvertListFeature(dependencies: featureDeps)
    }

    private func makeCategorySelectionFeature() -> CategorySelectionFeature {
        let featureDeps = UICategorySelectionFeature.Dependencies(categoryService: deps.categoryService)
        return UICategorySelectionFeature(dependencies: featureDeps)
    }
}
