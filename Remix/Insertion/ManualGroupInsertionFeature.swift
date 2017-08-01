//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import GroupSelection

class ManualGroupInsertionFeature {

    struct Dependencies {
        let textEntryStepViewFactory: TextEntryStepViewFactory
        let groupSelectionFeature: GroupSelectionFeature
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> ManualGroupInsertionCoordinator {
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
        return InsertionInteractor()
    }

    private func makeTitleStepFormatter() -> TitleStepFormatter {
        return TitleStepFormatter()
    }
}
