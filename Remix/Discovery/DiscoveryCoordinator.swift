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

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        discoveryInteractor = DiscoveryInteractor()
    }

    func start() {
        pushDiscoveryListView()
        updateDiscoveryListView()
    }

    private func pushDiscoveryListView() {
        var discoveryListView = dependencies.discoveryListViewWireframe.make()
        discoveryListView.delegate = self
        self.discoveryListView = discoveryListView
        dependencies.navigator.push(view: discoveryListView)
    }

    private func updateDiscoveryListView(selectedCategoryID: CategoryID? = nil) {
        discoveryInteractor.update(selectedCategoryID: selectedCategoryID) { [weak self] ads in
            let viewData = DiscoveryFormatter().prepare(ads: ads)
            self?.discoveryListView?.viewData = viewData
        }
    }
}

extension DiscoveryCoordinator: DiscoveryListViewDelegate {

    func didSelect(classifiedAdID: ClassifiedAdID) {
        pushDetailView(for: classifiedAdID)
    }

    private func pushDetailView(for classifiedAdID: ClassifiedAdID) {
        var detailView = dependencies.detailViewWireframe.make()
        discoveryInteractor.fetchDetail(for: classifiedAdID) { [weak self] classifiedAd in
            guard let classifiedAd = classifiedAd else { preconditionFailure() }
            detailView.viewData = DiscoveryDetailFormatter().prepare(item: classifiedAd)
            self?.detailView = detailView
            self?.dependencies.navigator.push(view: detailView)
        }
    }

    func doesWantFilters() {
        startCategorySelection()
    }

    private func startCategorySelection() {
        let wireframe = CategorySelectionListViewControllerWireframe()
        let categorySelectionDependencies = CategorySelectionDependencies(navigator: dependencies.navigator, categorySelectionListViewWireframe: wireframe)
        let categorySelection = CategorySelectionCoordinator(dependencies: categorySelectionDependencies)
        categorySelection.delegate = self
        self.categorySelection = categorySelection
        categorySelection.start()
    }
}

extension DiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    func didSelect(categoryID: CategoryID?) {
        updateDiscoveryListView(selectedCategoryID: categoryID)
    }
}
