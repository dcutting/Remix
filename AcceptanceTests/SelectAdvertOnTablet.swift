//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import GroupSelection

@objc(SelectAdvertOnTablet)
class SelectAdvertOnTablet: NSObject {

    @objc var title: String?
    @objc var group: String?

    let advertListViewSpy = AdvertListViewSpy()
    let itemDetailViewSpy = ItemDetailViewSpy()
    let navigationWireframeSpy = NavigationWireframeSpy()
    let splitWireframeSpy = SplitWireframeSpy()

    var splitDiscoveryCoordinator: SplitDiscoveryCoordinator?

    @objc override init() {
        let fakeAdvertListViewFactory = FakeAdvertListViewFactory(fake: advertListViewSpy)

        let fakeItemDetailViewFactory = FakeItemDetailViewFactory(fake: itemDetailViewSpy)

        let fakeNavigationWireframeFactory = FakeNavigationWireframeFactory(fake: navigationWireframeSpy)

        let groupSelectionViewSpy = GroupSelectionViewSpy()
        let fakeGroupSelectionViewFactory = FakeGroupSelectionViewFactory(fake: groupSelectionViewSpy)

        let groupSelectionDependencies = GroupSelectionFeature.Dependencies(
            groupService: mockGroupService,
            groupSelectionViewFactory: fakeGroupSelectionViewFactory)
        let groupSelectionFeature = GroupSelectionFeature(dependencies: groupSelectionDependencies)

        let deps = SplitDiscoveryFeature.Dependencies(
            advertService: mockAdvertService,
            groupService: mockGroupService,
            advertListViewFactory: fakeAdvertListViewFactory,
            itemDetailViewFactory: fakeItemDetailViewFactory,
            navigationWireframeFactory: fakeNavigationWireframeFactory,
            groupSelectionFeature: groupSelectionFeature)
        let feature = SplitDiscoveryFeature(dependencies: deps)
        splitDiscoveryCoordinator = feature.makeCoordinatorUsing(splitWireframe: splitWireframeSpy)
    }

    @objc func selectAdvert(_ advertID: String) -> Bool {

        guard let coordinator = splitDiscoveryCoordinator else { return false }
        coordinator.start()

        guard let delegate = advertListViewSpy.delegate else { return false }
        delegate.didSelect(advertID: advertID)

        return true
    }

    @objc func displaysAdvertInSplitDetailView() -> Bool {
        return splitWireframeSpy.detail === itemDetailViewSpy
    }

    @objc func detailViewTitle() -> String {
        return itemDetailViewSpy.viewData?.title ?? ""
    }
}

