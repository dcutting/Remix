//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class UICategorySelectionFeature: CategorySelectionFeature {

    let categoryService: CategoryService

    init(categoryService: CategoryService) {
        self.categoryService = categoryService
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> CategorySelectionCoordinator {
        let dependencies = CategorySelectionCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            categorySelectionViewFactory: makeViewFactory(),
            interactor: makeInteractor(),
            formatter: makeFormatter()
        )
        return CategorySelectionCoordinator(dependencies: dependencies)
    }

    private func makeViewFactory() -> CategorySelectionViewFactory {
        return CategorySelectionViewControllerFactory()
    }

    private func makeInteractor() -> CategorySelectionInteractor {
        return CategorySelectionInteractor(categoryService: categoryService)
    }

    private func makeFormatter() -> CategorySelectionFormatter {
        return CategorySelectionFormatter()
    }
}
