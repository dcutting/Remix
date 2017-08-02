//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Services
import GroupSelection

class AlternatingInsertionFeature: InsertionFeature {

    struct Dependencies {
        let advertService: AdvertService
        let groupRecommendationService: GroupRecommendationService
        let toastWireframeFactory: ToastWireframeFactory
        let textEntryStepViewFactory: TextEntryStepViewFactory
        let groupSelectionFeature: GroupSelectionFeature
    }

    private let deps: Dependencies
    private var currentSubfeatureIndex = 0

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> InsertionCoordinator {
        defer {
            currentSubfeatureIndex += 1
        }
        let feature = makeFeature()
        return feature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
    }

    private func makeFeature() -> InsertionFeature {
        switch currentSubfeatureIndex % 2 {
        case 0:
            return makeManualFeature()
        default:
            return makeAutoFeature()
        }
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
            groupRecommendationService: deps.groupRecommendationService,
            toastWireframeFactory: deps.toastWireframeFactory,
            textEntryStepViewFactory: deps.textEntryStepViewFactory
        )
        return AutoGroupInsertionFeature(dependencies: featureDeps)
    }
}
