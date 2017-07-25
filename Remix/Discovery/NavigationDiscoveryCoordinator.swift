//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

struct NavigationDiscoveryCoordinatorDependencies: NavigationDiscoveryCoordinator.Dependencies {
    let navigationCoordinator: NavigationCoordinator
    let discoveryListViewFactory: DiscoveryListViewFactory
    let detailViewFactory: DetailViewFactory
}

class NavigationDiscoveryCoordinator {

    typealias Dependencies = HasNavigationCoordinator & HasDiscoveryListViewFactory & HasDetailViewFactory

    private let dependencies: Dependencies
    private let discoveryInteractor = DiscoveryInteractor()
    private let discoveryListFormatter = DiscoveryListFormatter()
    private let discoveryDetailFormatter = DiscoveryDetailFormatter()
    
    private var discoveryListView: DiscoveryListView?
    private var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        pushListView()
        updateListView()
    }
}

extension NavigationDiscoveryCoordinator: DiscoveryListViewDelegate {

    private func pushListView() {
        let view = dependencies.discoveryListViewFactory.make()
        view.delegate = self
        self.discoveryListView = view
        dependencies.navigationCoordinator.push(view: view)
    }

    private func updateListView(forSelectedCategoryID selectedCategoryID: CategoryID? = nil) {
        discoveryInteractor.update(selectedCategoryID: selectedCategoryID) { [weak self] (ads, categories) in
            self?.updateListView(withAds: ads, categories: categories)
        }
    }

    private func updateListView(withAds ads: [ClassifiedAd], categories: [Category]) {
        let viewData = discoveryListFormatter.prepare(ads: ads, categories: categories)
        discoveryListView?.viewData = viewData
    }

    func didSelect(classifiedAdID: ClassifiedAdID) {
        pushDetailView(forClassifiedAdID: classifiedAdID)
    }

    func doesWantFilters() {
        startCategorySelection()
    }
}

extension NavigationDiscoveryCoordinator {

    private func pushDetailView(forClassifiedAdID classifiedAdID: ClassifiedAdID) {
        discoveryInteractor.fetchDetail(for: classifiedAdID) { [weak self] ad in
            guard let ad = ad else { preconditionFailure() }
            self?.pushDetailView(forAd: ad)
        }
    }

    private func pushDetailView(forAd ad: ClassifiedAd) {
        let detailView = dependencies.detailViewFactory.make()
        detailView.viewData = discoveryDetailFormatter.prepare(ad: ad)
        dependencies.navigationCoordinator.push(view: detailView)
    }
}

extension NavigationDiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    private func startCategorySelection() {
        let coordinator = makeCategorySelectionCoordinator()
        coordinator.delegate = self
        self.categorySelectionCoordinator = coordinator
        dependencies.navigationCoordinator.setPopCheckpoint()
        coordinator.start()
    }

    private func makeCategorySelectionCoordinator() -> CategorySelectionCoordinator {
        let factory = CategorySelectionListViewControllerFactory()
        let coordinatorDependencies = CategorySelectionDependencies(
            navigationCoordinator: dependencies.navigationCoordinator,
            categorySelectionListViewFactory: factory
        )
        return CategorySelectionCoordinator(dependencies: coordinatorDependencies)
    }

    func didSelect(categoryID: CategoryID?) {
        updateListView(forSelectedCategoryID: categoryID)
        finishCategorySelection()
    }

    func didCancelSelection() {
        finishCategorySelection()
    }

    private func finishCategorySelection() {
        dependencies.navigationCoordinator.popToLastCheckpoint()
        categorySelectionCoordinator = nil
    }
}
