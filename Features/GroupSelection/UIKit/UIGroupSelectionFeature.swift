//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity
import Services

public class UIGroupSelectionFeature: GroupSelectionFeature {

    public struct Dependencies {
        let groupService: GroupService

        public init(groupService: GroupService) {
            self.groupService = groupService
        }
    }

    private let deps: Dependencies

    public init(dependencies: Dependencies) {
        deps = dependencies
    }

    public func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> GroupSelectionCoordinator {
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
