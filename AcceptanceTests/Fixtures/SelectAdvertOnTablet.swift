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
    let splitWireframeSpy = SplitWireframeSpy()

    var splitDiscoveryCoordinator: SplitDiscoveryCoordinator?

    @objc override init() {
        super.init()

        let featureFactory = TestableDiscoveryFeatureFactory(advertListView: advertListViewSpy, itemDetailView: itemDetailViewSpy)
        let feature = featureFactory.make()

        splitDiscoveryCoordinator = feature.makeSplitDiscoveryCoordinator(splitWireframe: splitWireframeSpy)
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
