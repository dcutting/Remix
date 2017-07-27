//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity
import Wireframe

class UIGroupSelectionFeature: GroupSelectionFeature {

    struct Dependencies {
        let groupService: GroupService
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> GroupSelectionCoordinator {
        let dependencies = GroupSelectionCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            groupSelectionViewFactory: makeViewFactory(),
            interactor: makeInteractor(),
            formatter: makeFormatter()
        )
        return GroupSelectionCoordinator(dependencies: dependencies)
    }

    private func makeViewFactory() -> GroupSelectionViewFactory {
        return GroupSelectionViewControllerFactory()
    }

    private func makeInteractor() -> GroupSelectionInteractor {
        return GroupSelectionInteractor(groupService: deps.groupService)
    }

    private func makeFormatter() -> GroupSelectionFormatter {
        return GroupSelectionFormatter()
    }
}
