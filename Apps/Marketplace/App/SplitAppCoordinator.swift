//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Service
import GroupSelectionFeature

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
            navigationWireframeFactory: UINavigationWireframeFactory(),
            advertService: deps.advertService,
            itemDetailViewFactory: ItemDetailViewControllerFactory(),
            advertListFeature: makeAdvertListFeature(),
            groupSelectionFeature: groupSelectionFeature,
            insertionFeature: makeInsertionFeature(using: groupSelectionFeature)
        )
        return SplitDiscoveryFeature(dependencies: discoveryDeps)
    }

    private func makeGroupSelectionFeature() -> GroupSelectionFeature {
        let featureDeps = GroupSelectionFeature.Dependencies(groupService: deps.groupService, groupSelectionViewFactory: GroupSelectionViewControllerFactory())
        return GroupSelectionFeature(dependencies: featureDeps)
    }

    private func makeAdvertListFeature() -> AdvertListFeature {
        let featureDeps = AdvertListFeature.Dependencies(
            advertService: deps.advertService,
            groupService: deps.groupService,
            advertListViewFactory: makeAdvertListViewFactory()
        )
        return AdvertListFeature(dependencies: featureDeps)
    }

    private func makeAdvertListViewFactory() -> AdvertListViewFactory {
        return AdvertListViewControllerFactory()
    }

    private func makeInsertionFeature(using groupSelectionFeature: GroupSelectionFeature) -> InsertionFeature {
        let textEntryStepViewFactory = makeTextEntryStepViewFactory()
        let manualGroupInsertionFeature = makeManualGroupInsertionFeature(using: groupSelectionFeature, textEntryStepViewFactory: textEntryStepViewFactory)
        let autoGroupInsertionFeature = makeAutoGroupInsertionFeature(using: textEntryStepViewFactory)
        let featureDeps = AlternatingInsertionFeature.Dependencies(
            subfeatures: [manualGroupInsertionFeature, autoGroupInsertionFeature]
        )
        return AlternatingInsertionFeature(dependencies: featureDeps)
    }

    private func makeManualGroupInsertionFeature(using groupSelectionFeature: GroupSelectionFeature, textEntryStepViewFactory: TextEntryStepViewFactory) -> ManualGroupInsertionFeature {
        let featureDeps = ManualGroupInsertionFeature.Dependencies(
            advertService: deps.advertService,
            textEntryStepViewFactory: textEntryStepViewFactory,
            groupSelectionFeature: groupSelectionFeature
        )
        return ManualGroupInsertionFeature(dependencies: featureDeps)
    }

    private func makeAutoGroupInsertionFeature(using textEntryStepViewFactory: TextEntryStepViewFactory) -> AutoGroupInsertionFeature {
        let featureDeps = AutoGroupInsertionFeature.Dependencies(
            toastWireframeFactory: makeToastWireframeFactory(),
            advertService: deps.advertService,
            groupRecommendationService: deps.groupRecommendationService,
            textEntryStepViewFactory: textEntryStepViewFactory
        )
        return AutoGroupInsertionFeature(dependencies: featureDeps)
    }

    private func makeToastWireframeFactory() -> ToastWireframeFactory {
        return UIToastWireframeFactory()
    }

    private func makeTextEntryStepViewFactory() -> TextEntryStepViewFactory {
        return TextEntryStepViewControllerFactory()
    }
}
