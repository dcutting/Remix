//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import GroupSelectionFeature

@objc(SelectAdvertOnPhone)
class SelectAdvertOnPhone: NSObject {

    @objc var title: String?
    @objc var group: String?

    let advertListViewSpy = AdvertListViewSpy()
    let itemDetailViewSpy = ItemDetailViewSpy()
    let navigationWireframeSpy = NavigationWireframeSpy()

    var navigationDiscoveryCoordinator: NavigationDiscoveryCoordinator?

    @objc override init() {

        let fakeItemDetailViewFactory = FakeItemDetailViewFactory(fake: itemDetailViewSpy)

        super.init()

        let advertListFeature = makeAdvertListFeature()
        let groupSelectionFeature = makeGroupSelectionFeature()
        let insertionFeature = makeInsertionFeature(groupSelectionFeature: groupSelectionFeature)

        let deps = NavigationDiscoveryFeature.Dependencies(
            advertService: mockAdvertService,
            itemDetailViewFactory: fakeItemDetailViewFactory,
            advertListFeature: advertListFeature,
            insertionFeature: insertionFeature,
            groupSelectionFeature: groupSelectionFeature)
        let feature = NavigationDiscoveryFeature(dependencies: deps)
        navigationDiscoveryCoordinator = feature.makeCoordinatorUsing(navigationWireframe: navigationWireframeSpy)
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

    private func makeGroupSelectionFeature() -> GroupSelectionFeature {
        let groupSelectionViewSpy = GroupSelectionViewSpy()
        let fakeGroupSelectionViewFactory = FakeGroupSelectionViewFactory(fake: groupSelectionViewSpy)
        let groupSelectionDependencies = GroupSelectionFeature.Dependencies(
            groupService: mockGroupService,
            groupSelectionViewFactory: fakeGroupSelectionViewFactory)
        return GroupSelectionFeature(dependencies: groupSelectionDependencies)
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
