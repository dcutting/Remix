//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Service
import GroupSelectionFeature

class ManualGroupInsertionFeature: InsertionFeature {

    struct Dependencies {
        let advertService: AdvertService
        let textEntryStepViewFactory: TextEntryStepViewFactory
        let groupSelectionFeature: GroupSelectionFeature
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinator(navigationWireframe: NavigationWireframe) -> InsertionCoordinator {
        let coordinatorDeps = ManualGroupInsertionCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            insertionInteractor: makeInteractor(),
            titleStepFormatter: TitleStepFormatter(),
            textEntryStepViewFactory: deps.textEntryStepViewFactory,
            groupSelectionFeature: deps.groupSelectionFeature
        )
        return ManualGroupInsertionCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> InsertionInteractor {
        return InsertionInteractor(advertService: deps.advertService)
    }
}
