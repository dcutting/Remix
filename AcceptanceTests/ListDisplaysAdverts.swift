//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe

@objc(ListDisplaysAdverts)
class ListDisplaysAdverts: NSObject {
    @objc var title: String?
    @objc var group: String?

    @objc func query() -> [[[String]]] {

//        let spyAdvertListView = AdvertListViewSpy()
//        let fakeAdvertListViewFactory = FakeAdvertListViewFactory(fake: spyAdvertListView)
//
//        let mockNavigationWireframe = NavigationWireframeSpy()
//
//        let deps = AdvertListCoordinator.Dependencies(
//            navigationWireframe: mockNavigationWireframe,
//            interactor: AdvertListInteractor(advertService: mockAdvertService, groupService: mockGroupService),
//            formatter: AdvertListFormatter(),
//            viewFactory: fakeAdvertListViewFactory)
//        let advertListCoordinator = AdvertListCoordinator(dependencies: deps)
//
//        advertListCoordinator.start()
//
//        wait(seconds: 0.5)
//
//        guard let viewData = spyAdvertListView.viewData else {
//            return []
//        }

//        return spyAdvertListView.viewData?.items.map { item in [["title", item.title], ["group", item.group]] }
//
        return []
    }

    private func wait(seconds: TimeInterval) {
        RunLoop.current.run(until: Date() + seconds)
    }
}
