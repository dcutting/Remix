//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Services
import GroupSelection

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

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> InsertionCoordinator {
        let coordinatorDeps = ManualGroupInsertionCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            insertionInteractor: makeInteractor(),
            titleStepFormatter: makeTitleStepFormatter(),
            textEntryStepViewFactory: deps.textEntryStepViewFactory,
            groupSelectionFeature: deps.groupSelectionFeature
        )
        return ManualGroupInsertionCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> InsertionInteractor {
        return InsertionInteractor(advertService: deps.advertService)
    }

    private func makeTitleStepFormatter() -> TitleStepFormatter {
        return TitleStepFormatter()
    }
}
