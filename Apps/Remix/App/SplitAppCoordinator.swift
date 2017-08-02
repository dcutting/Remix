//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Services
import GroupSelection

class SplitAppCoordinator {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
        let groupRecommendationService: GroupRecommendationService
    }

    private let deps: Dependencies
    private let splitWireframe = UISplitWireframe()
    private var discoveryCoordinator: SplitDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = splitWireframe.viewController
    }

    func start() {
        let feature = makeFeature()
        let coordinator = feature.makeCoordinatorUsing(splitWireframe: splitWireframe)
        discoveryCoordinator = coordinator
        coordinator.start()
    }

    private func makeFeature() -> SplitDiscoveryFeature {
        let groupSelectionFeature = makeGroupSelectionFeature()
        
        let discoveryDeps = SplitDiscoveryFeature.Dependencies(
            advertService: deps.advertService,
            groupService: deps.groupService,
            advertListViewFactory: AdvertListViewControllerFactory(),
            itemDetailViewFactory: ItemDetailViewControllerFactory(),
            navigationWireframeFactory: UINavigationWireframeFactory(),
            groupSelectionFeature: groupSelectionFeature,
            insertionFeature: makeInsertionFeature(using: groupSelectionFeature)
        )
        return SplitDiscoveryFeature(dependencies: discoveryDeps)
    }

    private func makeGroupSelectionFeature() -> GroupSelectionFeature {
        let featureDeps = GroupSelectionFeature.Dependencies(groupService: deps.groupService, groupSelectionViewFactory: GroupSelectionViewControllerFactory())
        return GroupSelectionFeature(dependencies: featureDeps)
    }

    private func makeInsertionFeature(using groupSelectionFeature: GroupSelectionFeature) -> InsertionFeature {
        let featureDeps = AlternatingInsertionFeature.Dependencies(
            advertService: deps.advertService,
            groupRecommendationService: deps.groupRecommendationService,
            toastWireframeFactory: makeToastWireframeFactory(),
            textEntryStepViewFactory: makeTextEntryStepViewFactory(),
            groupSelectionFeature: groupSelectionFeature
        )
        return AlternatingInsertionFeature(dependencies: featureDeps)
    }

    private func makeToastWireframeFactory() -> ToastWireframeFactory {
        return UIToastWireframeFactory()
    }

    private func makeTextEntryStepViewFactory() -> TextEntryStepViewFactory {
        return TextEntryStepViewControllerFactory()
    }
}
