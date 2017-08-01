//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import GroupSelection

@objc(SelectAdvertOnPhone)
class SelectAdvertOnPhone: NSObject {

    @objc var title: String?
    @objc var group: String?

    let advertListViewSpy = AdvertListViewSpy()
    let itemDetailViewSpy = ItemDetailViewSpy()
    let navigationWireframeSpy = NavigationWireframeSpy()

    var navigationDiscoveryCoordinator: NavigationDiscoveryCoordinator?

    @objc override init() {
        let fakeAdvertListViewFactory = FakeAdvertListViewFactory(fake: advertListViewSpy)

        let fakeItemDetailViewFactory = FakeItemDetailViewFactory(fake: itemDetailViewSpy)

        let groupSelectionViewSpy = GroupSelectionViewSpy()
        let fakeGroupSelectionViewFactory = FakeGroupSelectionViewFactory(fake: groupSelectionViewSpy)

        let groupSelectionDependencies = GroupSelectionFeature.Dependencies(
            groupService: mockGroupService,
            groupSelectionViewFactory: fakeGroupSelectionViewFactory)
        let groupSelectionFeature = GroupSelectionFeature(dependencies: groupSelectionDependencies)

        let deps = NavigationDiscoveryFeature.Dependencies(
            advertService: mockAdvertService,
            groupService: mockGroupService,
            advertListViewFactory: fakeAdvertListViewFactory,
            itemDetailViewFactory: fakeItemDetailViewFactory,
            groupSelectionFeature: groupSelectionFeature)
        let feature = NavigationDiscoveryFeature(dependencies: deps)
        navigationDiscoveryCoordinator = feature.makeCoordinatorUsing(navigationWireframe: navigationWireframeSpy)
    }

    @objc func selectAdvert(_ advertID: String) -> Bool {

        guard let coordinator = navigationDiscoveryCoordinator else { return false }
        coordinator.start()

        guard let delegate = advertListViewSpy.delegate else { return false }
        delegate.didSelect(advertID: advertID)

        return true
    }

    @objc func pushesAdvertOntoNavigationStack() -> Bool {
        return navigationWireframeSpy.topView === itemDetailViewSpy
    }

    @objc func detailViewTitle() -> String {
        return itemDetailViewSpy.viewData?.title ?? ""
    }
}
