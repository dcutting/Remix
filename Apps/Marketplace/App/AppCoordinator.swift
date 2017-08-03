//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity
import Service
import GroupSelectionFeature

class AppCoordinator {

    private var discoveryCoordinator: Any?

    func start(window: UIWindow) {
        if UI_USER_INTERFACE_IDIOM() == .pad {
            discoveryCoordinator = start_iPad(window: window)
        } else {
            discoveryCoordinator = start_iPhone(window: window)
        }
    }

    private func start_iPad(window: UIWindow) -> Any {
        let splitWireframe = UISplitWireframe()
        window.rootViewController = splitWireframe.viewController
        let feature = makeDiscoveryFeature()
        let coordinator = feature.makeSplitDiscoveryCoordinator(splitWireframe: splitWireframe)
        coordinator.start()
        return coordinator
    }

    private func start_iPhone(window: UIWindow) -> Any {
        let navigationWireframe = UINavigationWireframe()
        window.rootViewController = navigationWireframe.viewController
        let feature = makeDiscoveryFeature()
        let coordinator = feature.makeNavigationDiscoveryCoordinator(navigationWireframe: navigationWireframe)
        coordinator.start()
        return coordinator
    }
}



/* Dependency injection. */

extension AppCoordinator {

    private func makeDiscoveryFeature() -> DiscoveryFeature {

        let advertService = makeAdvertService()
        let groupService = makeGroupService()
        let groupRecommendationService = makeGroupRecommendationService()
        let groupSelectionFeature = makeGroupSelectionFeature(groupService: groupService)
        let insertionFeature = makeInsertionFeature(advertService: advertService, groupRecommendationService: groupRecommendationService, groupSelectionFeature: groupSelectionFeature)

        let featureDeps = DiscoveryFeature.Dependencies(
            navigationWireframeFactory: UINavigationWireframeFactory(),
            advertService: advertService,
            itemDetailViewFactory: ItemDetailViewControllerFactory(),
            advertListFeature: makeAdvertListFeature(advertService: advertService, groupService: groupService),
            groupSelectionFeature: groupSelectionFeature,
            insertionFeature: insertionFeature
        )
        return DiscoveryFeature(dependencies: featureDeps)
    }

    private func makeAdvertListFeature(advertService: AdvertService, groupService: GroupService) -> AdvertListFeature {
        let featureDeps = AdvertListFeature.Dependencies(
            advertService: advertService,
            groupService: groupService,
            advertListViewFactory: AdvertListViewControllerFactory()
        )
        return AdvertListFeature(dependencies: featureDeps)
    }

    private func makeGroupSelectionFeature(groupService: GroupService) -> GroupSelectionFeature {
        let featureDeps = GroupSelectionFeature.Dependencies(
            groupService: groupService,
            groupSelectionViewFactory: GroupSelectionViewControllerFactory()
        )
        return GroupSelectionFeature(dependencies: featureDeps)
    }

    private func makeInsertionFeature(advertService: AdvertService, groupRecommendationService: GroupRecommendationService, groupSelectionFeature: GroupSelectionFeature) -> InsertionFeature {

        let textEntryStepViewFactory = TextEntryStepViewControllerFactory()

        let manualGroupInsertionFeature = makeManualGroupInsertionFeature(advertService: advertService, textEntryStepViewFactory: textEntryStepViewFactory, groupSelectionFeature: groupSelectionFeature)
        let autoGroupInsertionFeature = makeAutoGroupInsertionFeature(advertService: advertService, groupRecommendationService: groupRecommendationService, textEntryStepViewFactory: textEntryStepViewFactory)

        let featureDeps = AlternatingInsertionFeature.Dependencies(
            subfeatures: [manualGroupInsertionFeature, autoGroupInsertionFeature]
        )
        return AlternatingInsertionFeature(dependencies: featureDeps)
    }

    private func makeManualGroupInsertionFeature(advertService: AdvertService, textEntryStepViewFactory: TextEntryStepViewFactory, groupSelectionFeature: GroupSelectionFeature) -> ManualGroupInsertionFeature {
        let featureDeps = ManualGroupInsertionFeature.Dependencies(
            advertService: advertService,
            textEntryStepViewFactory: textEntryStepViewFactory,
            groupSelectionFeature: groupSelectionFeature
        )
        return ManualGroupInsertionFeature(dependencies: featureDeps)
    }

    private func makeAutoGroupInsertionFeature(advertService: AdvertService, groupRecommendationService: GroupRecommendationService, textEntryStepViewFactory: TextEntryStepViewFactory) -> AutoGroupInsertionFeature {
        let featureDeps = AutoGroupInsertionFeature.Dependencies(
            toastWireframeFactory: UIToastWireframeFactory(),
            advertService: advertService,
            groupRecommendationService: groupRecommendationService,
            textEntryStepViewFactory: textEntryStepViewFactory
        )
        return AutoGroupInsertionFeature(dependencies: featureDeps)
    }

    private func makeAdvertService() -> AdvertService {
        let service = MockAdvertService()
        service.adverts = [
            Advert(advertID: "1", title: "Specialized", description: "A battered mountain bike well past its glory days.", groupID: "4"),
            Advert(advertID: "2", title: "Cervelo R2", description: "A superb racing bike in mint condition. Only used once to compete in the Tour de France.", groupID: "5"),
            Advert(advertID: "3", title: "Fiat 500", description: "The Fiat 500 is a rear-engined two-door, four seat, small city car manufactured and marketed by Fiat Automobiles from 1957 to 1975 over a single generation in 2-door saloon and 2-door station wagon bodystyles.", groupID: "10"),
            Advert(advertID: "4", title: "Apollo Jewel", description: "A lightweight yet strong aluminium frame makes the Apollo Jewel Women's Mountain Bike a standout when it comes to value for money.", groupID: "4")
        ]
        return service
    }

    private func makeGroupService() -> GroupService {
        let service = MockGroupService()
        service.groups = [
            Group(groupID: "1", parent: nil, children: ["2", "5"], title: "Bicycles", description: ""),
            Group(groupID: "2", parent: "1", children: ["3", "4"], title: "Off road bikes", description: ""),
            Group(groupID: "3", parent: "2", children: [], title: "Trail bikes", description: ""),
            Group(groupID: "4", parent: "2", children: [], title: "Mountain bikes", description: ""),
            Group(groupID: "5", parent: "1", children: [], title: "Racers", description: ""),
            Group(groupID: "10", parent: nil, children: [], title: "Cars", description: "")
        ]
        return service
    }

    private func makeGroupRecommendationService() -> GroupRecommendationService {
        let service = MockGroupRecommendationService(defaultGroupID: "10")
        service.mappings = [
            ("mountain", "4"),
            ("racing", "5"),
            ("bike", "3"),
            ("car", "10"),
            ("truck", "10")
        ]
        return service
    }
}
