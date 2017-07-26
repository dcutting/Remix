//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class UIAdvertListFeature: AdvertListFeature {

    let advertService: AdvertService
    let categoryService: CategoryService

    init(advertService: AdvertService, categoryService: CategoryService) {
        self.advertService = advertService
        self.categoryService = categoryService
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
        return AdvertListInteractor(advertService: advertService, categoryService: categoryService)
    }

    private func makeFormatter() -> AdvertListFormatter {
        return AdvertListFormatter()
    }

    private func makeViewFactory() -> AdvertListViewFactory {
        return AdvertListViewControllerFactory()
    }
}
