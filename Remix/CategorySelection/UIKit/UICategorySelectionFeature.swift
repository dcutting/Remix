//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class UICategorySelectionFeature: CategorySelectionFeature {

    struct Dependencies {
        let categoryService: CategoryService
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
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
        return CategorySelectionInteractor(categoryService: deps.categoryService)
    }

    private func makeFormatter() -> CategorySelectionFormatter {
        return CategorySelectionFormatter()
    }
}
