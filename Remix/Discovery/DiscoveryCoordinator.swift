//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryCoordinator {

    let navigator: Navigator
    var discoveryListView: DiscoveryListView?
    var detailView: DetailView?

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func start() {
        let discoveryListView = DiscoveryListViewFake()
        discoveryListView.delegate = self
        self.discoveryListView = discoveryListView
        navigator.push(view: discoveryListView)
    }
}

extension DiscoveryCoordinator: DiscoveryListViewDelegate {

    func didSelectItem(at: Int) {
        let detailView = DetailViewFake()
        self.detailView = detailView
        navigator.push(view: detailView)
    }
}
