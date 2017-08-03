//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Service
import GroupSelectionFeature

class NavigationAppCoordinator {

    struct Dependencies {
        let advertService: AdvertService
        let groupService: GroupService
        let groupRecommendationService: GroupRecommendationService
    }

    private let deps: Dependencies
    private let navigationWireframe = UINavigationWireframe()
    private var discoveryCoordinator: NavigationDiscoveryCoordinator?

    init(window: UIWindow, dependencies: Dependencies) {
        deps = dependencies
        window.rootViewController = navigationWireframe.viewController
    }

    func start() {
        let groupSelectionFeature = makeGroupSelectionFeature()
        let discoveryFeature = makeDiscoveryFeature(using: groupSelectionFeature)
        let coordinator = discoveryFeature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
        discoveryCoordinator = coordinator
        coordinator.start()
    }

    private func makeDiscoveryFeature(using groupSelectionFeature: GroupSelectionFeature) -> NavigationDiscoveryFeature {
        let discoveryDeps = NavigationDiscoveryFeature.Dependencies(
            advertService: deps.advertService,
            itemDetailViewFactory: ItemDetailViewControllerFactory(),
            advertListFeature: makeAdvertListFeature(),
            insertionFeature: makeInsertionFeature(using: groupSelectionFeature),
            groupSelectionFeature: groupSelectionFeature
        )
        return NavigationDiscoveryFeature(dependencies: discoveryDeps)
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

    private func makeGroupSelectionFeature() -> GroupSelectionFeature {
        let featureDeps = GroupSelectionFeature.Dependencies(groupService: deps.groupService, groupSelectionViewFactory: GroupSelectionViewControllerFactory())
        return GroupSelectionFeature(dependencies: featureDeps)
    }
}
