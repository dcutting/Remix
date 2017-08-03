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
        super.init()
        
        let featureFactory = TestableDiscoveryFeatureFactory(advertListView: advertListViewSpy, itemDetailView: itemDetailViewSpy)
        let feature = featureFactory.make()

        navigationDiscoveryCoordinator = feature.makeNavigationDiscoveryCoordinator(navigationWireframe: navigationWireframeSpy)
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
