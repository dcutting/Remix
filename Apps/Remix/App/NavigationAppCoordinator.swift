//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Wireframe
import Entity
import Services
import GroupSelection

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
            groupService: deps.groupService,
            advertListViewFactory: AdvertListViewControllerFactory(),
            itemDetailViewFactory: ItemDetailViewControllerFactory(),
            insertionFeature: makeInsertionFeature(using: groupSelectionFeature),
            groupSelectionFeature: groupSelectionFeature
        )
        return NavigationDiscoveryFeature(dependencies: discoveryDeps)
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
