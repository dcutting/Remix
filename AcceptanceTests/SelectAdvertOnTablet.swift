//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import GroupSelectionFeature

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
        super.init()

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
            itemDetailViewFactory: fakeItemDetailViewFactory,
            navigationWireframeFactory: fakeNavigationWireframeFactory,
            advertListFeature: makeAdvertListFeature(),
            groupSelectionFeature: groupSelectionFeature,
            insertionFeature: makeInsertionFeature(groupSelectionFeature: groupSelectionFeature)
        )
        let feature = SplitDiscoveryFeature(dependencies: deps)
        splitDiscoveryCoordinator = feature.makeCoordinatorUsing(splitWireframe: splitWireframeSpy)
    }

    private func makeAdvertListFeature() -> AdvertListFeature {

        let fakeAdvertListViewFactory = FakeAdvertListViewFactory(fake: advertListViewSpy)

        let featureDeps = AdvertListFeature.Dependencies(
            advertService: mockAdvertService,
            groupService: mockGroupService,
            advertListViewFactory: fakeAdvertListViewFactory
        )
        return AdvertListFeature(dependencies: featureDeps)
    }

    private func makeInsertionFeature(groupSelectionFeature: GroupSelectionFeature) -> ManualGroupInsertionFeature {
        let featureDeps = ManualGroupInsertionFeature.Dependencies(
            advertService: mockAdvertService,
            textEntryStepViewFactory: makeTextEntryStepViewFactory(),
            groupSelectionFeature: groupSelectionFeature
        )
        return ManualGroupInsertionFeature(dependencies: featureDeps)
    }

    private func makeTextEntryStepViewFactory() -> TextEntryStepViewFactory {
        return FakeTextEntryStepViewFactory(fake: TextEntryStepViewSpy())
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

