//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Services
import GroupSelection

class InsertionFeature {

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
        let coordinatorDeps = InsertionCoordinator.Dependencies(
            navigationWireframe: navigationWireframe,
            manualFeature: makeManualFeature(),
            autoFeature: makeAutoFeature()
        )
        return InsertionCoordinator(dependencies: coordinatorDeps)
    }

    private func makeManualFeature() -> ManualGroupInsertionFeature {
        let featureDeps = ManualGroupInsertionFeature.Dependencies(
            advertService: deps.advertService,
            textEntryStepViewFactory: deps.textEntryStepViewFactory,
            groupSelectionFeature: deps.groupSelectionFeature
        )
        return ManualGroupInsertionFeature(dependencies: featureDeps)
    }

    private func makeAutoFeature() -> AutoGroupInsertionFeature {
        let featureDeps = AutoGroupInsertionFeature.Dependencies(
            advertService: deps.advertService,
            textEntryStepViewFactory: deps.textEntryStepViewFactory
        )
        return AutoGroupInsertionFeature(dependencies: featureDeps)
    }
}
