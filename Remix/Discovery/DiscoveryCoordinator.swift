//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class DiscoveryCoordinator {

    private let navigator: Navigator
    private let discoveryInteractor: DiscoveryInteractor
    private var discoveryListView: DiscoveryListView?
    private var detailView: DetailView?
    private var categorySelection: CategorySelectionCoordinator?

    init(navigator: Navigator) {
        self.navigator = navigator
        discoveryInteractor = DiscoveryInteractor()
    }

    func start() {
        pushDiscoveryListView()
        updateDiscoveryListView()
    }

    private func pushDiscoveryListView() {
        let discoveryListView = DiscoveryListViewFake()
        discoveryListView.delegate = self
        self.discoveryListView = discoveryListView
        navigator.push(view: discoveryListView)
    }

    private func updateDiscoveryListView(selectedCategoryID: CategoryID? = nil) {
        discoveryInteractor.update(selectedCategoryID: selectedCategoryID) { [weak self] ads in
            let viewData = DiscoveryFormatter().prepare(ads: ads)
            self?.discoveryListView?.viewData = viewData
        }
    }
}

extension DiscoveryCoordinator: DiscoveryListViewDelegate {

    func didSelectItem(at index: Int) {
        pushDetailView(for: index)
    }

    private func pushDetailView(for index: Int) {
        let detailView = DetailViewFake()
        self.detailView = detailView
        navigator.push(view: detailView)
    }

    func doesWantFilters() {
        startCategorySelection()
    }

    private func startCategorySelection() {
        let categorySelection = CategorySelectionCoordinator(navigator: navigator)
        categorySelection.delegate = self
        self.categorySelection = categorySelection
        categorySelection.start()
    }
}

extension DiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    func didSelectCategory(id: CategoryID) {
        updateDiscoveryListView(selectedCategoryID: id)
    }
}
