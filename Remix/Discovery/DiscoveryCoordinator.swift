//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryCoordinator {

    let navigator: Navigator
    var discoveryListView: DiscoveryListView?
    var detailView: DetailView?
    var categorySelection: CategorySelectionCoordinator?
    let discoveryInteractor: DiscoveryInteractor

    init(navigator: Navigator) {
        self.navigator = navigator
        discoveryInteractor = DiscoveryInteractor()
    }

    func start() {
        let discoveryListView = DiscoveryListViewFake()
        discoveryListView.delegate = self
        self.discoveryListView = discoveryListView
        navigator.push(view: discoveryListView)
    }
}

extension DiscoveryCoordinator: DiscoveryListViewDelegate {

    func didSelectItem(at index: Int) {
        let detailView = DetailViewFake()
        self.detailView = detailView
        navigator.push(view: detailView)
    }

    func doesWantFilters() {
        let categorySelection = CategorySelectionCoordinator(navigator: navigator)
        categorySelection.delegate = self
        self.categorySelection = categorySelection
        categorySelection.start()
    }
}

extension DiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    func didSelectCategory(id: CategoryID) {
        discoveryInteractor.update(selectedCategoryID: id) { [weak self] ads in
            let viewData = DiscoveryFormatter().prepare(ads: ads)
            self?.discoveryListView?.viewData = viewData
        }
    }
}
