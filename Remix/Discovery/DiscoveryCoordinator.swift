//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

struct DiscoveryCoordinatorDependencies: DiscoveryCoordinator.Dependencies {
    let navigator: Navigator
    let discoveryListViewWireframe: DiscoveryListViewWireframe
    let detailViewWireframe: DetailViewWireframe
}

class DiscoveryCoordinator {

    typealias Dependencies = HasNavigator & HasDiscoveryListViewWireframe & HasDetailViewWireframe

    private let dependencies: Dependencies
    private let discoveryInteractor: DiscoveryInteractor
    private var discoveryListView: DiscoveryListView?
    private var detailView: DetailView?
    private var categorySelection: CategorySelectionCoordinator?

    private var discoveryData: [ClassifiedAd]?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        discoveryInteractor = DiscoveryInteractor()
    }

    func start() {
        pushDiscoveryListView()
        updateDiscoveryListView()
    }

    private func pushDiscoveryListView() {
        var discoveryListView = dependencies.discoveryListViewWireframe.view
        discoveryListView.delegate = self
        self.discoveryListView = discoveryListView
        dependencies.navigator.push(view: discoveryListView)
    }

    private func updateDiscoveryListView(selectedCategoryID: CategoryID? = nil) {
        discoveryInteractor.update(selectedCategoryID: selectedCategoryID) { [weak self] ads in
            let viewData = DiscoveryFormatter().prepare(ads: ads)
            self?.discoveryData = ads
            self?.discoveryListView?.viewData = viewData
        }
    }
}

extension DiscoveryCoordinator: DiscoveryListViewDelegate {

    func didSelectItem(at index: Int) {
        pushDetailView(for: index)
    }

    private func pushDetailView(for index: Int) {
        guard let item = discoveryData?[index] else { preconditionFailure() }
        var detailView = dependencies.detailViewWireframe.view
        detailView.viewData = DiscoveryDetailFormatter().prepare(item: item)
        self.detailView = detailView
        dependencies.navigator.push(view: detailView)
    }

    func doesWantFilters() {
        startCategorySelection()
    }

    private func startCategorySelection() {
        let categorySelection = CategorySelectionCoordinator(navigator: dependencies.navigator)
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
