//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Service

public class GroupSelectionFeature {

    public struct Dependencies {
        let groupService: GroupService
        let groupSelectionViewFactory: GroupSelectionViewFactory

        public init(groupService: GroupService, groupSelectionViewFactory: GroupSelectionViewFactory) {
            self.groupService = groupService
            self.groupSelectionViewFactory = groupSelectionViewFactory
        }
    }

    private let deps: Dependencies

    public init(dependencies: Dependencies) {
        deps = dependencies
    }

    public func makeCoordinator(navigationWireframe: NavigationWireframe) -> GroupSelectionCoordinator {
        let coordinatorDeps = GroupSelectionCoordinator.Dependencies(
            navigator: navigationWireframe,
            viewFactory: deps.groupSelectionViewFactory,
            interactor: makeInteractor(),
            formatter: GroupSelectionFormatter()
        )
        return GroupSelectionCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> GroupSelectionInteractor {
        return GroupSelectionInteractor(groupService: deps.groupService)
    }
}

