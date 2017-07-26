//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class UIAdvertListFeature: AdvertListFeature {

    struct Dependencies {
        let advertService: AdvertService
        let categoryService: CategoryService
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> AdvertListCoordinator {
        let deps = AdvertListCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            interactor: makeInteractor(),
            formatter: makeFormatter(),
            viewFactory: makeViewFactory()
        )
        return AdvertListCoordinator(dependencies: deps)
    }

    private func makeInteractor() -> AdvertListInteractor {
        return AdvertListInteractor(advertService: deps.advertService, categoryService: deps.categoryService)
    }

    private func makeFormatter() -> AdvertListFormatter {
        return AdvertListFormatter()
    }

    private func makeViewFactory() -> AdvertListViewFactory {
        return AdvertListViewControllerFactory()
    }
}
