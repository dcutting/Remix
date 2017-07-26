//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class UICategorySelectionFeature: CategorySelectionFeature {

    func makeCoordinatorUsing(navigationCoordinator: NavigationCoordinator) -> CategorySelectionCoordinator {
        let dependencies = CategorySelectionCoordinator.Dependencies(
            navigationCoordinator: navigationCoordinator,
            categorySelectionListViewFactory: CategorySelectionListViewControllerFactory(),
            interactor: CategorySelectionInteractor(),
            formatter: CategorySelectionListFormatter()
        )
        return CategorySelectionCoordinator(dependencies: dependencies)
    }
}
