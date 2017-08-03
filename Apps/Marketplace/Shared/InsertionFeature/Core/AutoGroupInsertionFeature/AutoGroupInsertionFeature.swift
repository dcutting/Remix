//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Service

class AutoGroupInsertionFeature: InsertionFeature {

    struct Dependencies {
        let toastWireframeFactory: ToastWireframeFactory
        let advertService: AdvertService
        let groupRecommendationService: GroupRecommendationService
        let textEntryStepViewFactory: TextEntryStepViewFactory
    }

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> InsertionCoordinator {
        let coordinatorDeps = AutoGroupInsertionCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            toastWireframeFactory: deps.toastWireframeFactory,
            insertionInteractor: makeInteractor(),
            titleStepFormatter: TitleStepFormatter(),
            textEntryStepViewFactory: deps.textEntryStepViewFactory
        )
        return AutoGroupInsertionCoordinator(dependencies: coordinatorDeps)
    }

    private func makeInteractor() -> AutoGroupInsertionInteractor {
        let insertionInteractor = InsertionInteractor(advertService: deps.advertService)
        return AutoGroupInsertionInteractor(
            insertionInteractor: insertionInteractor,
            groupRecommendationService: deps.groupRecommendationService
        )
    }
}
