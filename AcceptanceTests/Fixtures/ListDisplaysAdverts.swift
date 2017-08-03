//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe

@objc(ListDisplaysAdverts)
class ListDisplaysAdverts: NSObject {
    
    @objc var title: String?
    @objc var group: String?

    @objc func query() -> [[[String]]] {

        let advertListViewSpy = AdvertListViewSpy()
        let fakeAdvertListViewFactory = FakeAdvertListViewFactory(fake: advertListViewSpy)
        let navigationWireframeSpy = NavigationWireframeSpy()

        let deps = AdvertListFeature.Dependencies(
            advertService: mockAdvertService,
            groupService: mockGroupService,
            advertListViewFactory: fakeAdvertListViewFactory)
        let feature = AdvertListFeature(dependencies: deps)
        let coordinator = feature.makeCoordinator(navigationWireframe: navigationWireframeSpy)

        coordinator.start()

        guard let viewData = advertListViewSpy.viewData else { return [] }
        return viewData.items.map { item in [["title", item.title], ["group", item.group]] }
    }
}
