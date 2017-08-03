//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import GroupSelectionFeature

class TestableDiscoveryFeatureFactory {

    let advertListView: AdvertListView
    let itemDetailView: ItemDetailView

    init(advertListView: AdvertListView, itemDetailView: ItemDetailView) {
        self.advertListView = advertListView
        self.itemDetailView = itemDetailView
    }

    func make() -> DiscoveryFeature {

        let fakeItemDetailViewFactory = FakeItemDetailViewFactory(fake: itemDetailView)

        let navigationWireframeSpy = NavigationWireframeSpy()
        let fakeNavigationWireframeFactory = FakeNavigationWireframeFactory(fake: navigationWireframeSpy)

        let groupSelectionViewSpy = GroupSelectionViewSpy()
        let fakeGroupSelectionViewFactory = FakeGroupSelectionViewFactory(fake: groupSelectionViewSpy)

        let groupSelectionDependencies = GroupSelectionFeature.Dependencies(
            groupService: mockGroupService,
            groupSelectionViewFactory: fakeGroupSelectionViewFactory)
        let groupSelectionFeature = GroupSelectionFeature(dependencies: groupSelectionDependencies)

        let deps = DiscoveryFeature.Dependencies(
            navigationWireframeFactory: fakeNavigationWireframeFactory,
            advertService: mockAdvertService,
            itemDetailViewFactory: fakeItemDetailViewFactory,
            advertListFeature: makeAdvertListFeature(),
            groupSelectionFeature: groupSelectionFeature,
            insertionFeature: makeInsertionFeature(groupSelectionFeature: groupSelectionFeature)
        )
        return DiscoveryFeature(dependencies: deps)
    }

    private func makeAdvertListFeature() -> AdvertListFeature {

        let fakeAdvertListViewFactory = FakeAdvertListViewFactory(fake: advertListView)

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
}
