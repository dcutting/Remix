//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Services

class AutoGroupInsertionFeature: InsertionFeature {

    struct Dependencies {
        let advertService: AdvertService
        let textEntryStepViewFactory: TextEntryStepViewFactory
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> InsertionCoordinator {
        let coordinatorDeps = AutoGroupInsertionCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            insertionInteractor: makeInteractor(),
            titleStepFormatter: makeTitleStepFormatter(),
            textEntryStepViewFactory: deps.textEntryStepViewFactory
        )
        return AutoGroupInsertionCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> InsertionInteractor {
        return InsertionInteractor(advertService: deps.advertService)
    }

    private func makeTitleStepFormatter() -> TitleStepFormatter {
        return TitleStepFormatter()
    }
}
