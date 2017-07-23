//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

struct NavigatorDiscoveryCoordinatorDependencies: NavigatorDiscoveryCoordinator.Dependencies {
    let navigator: Navigator
    let discoveryListViewWireframe: DiscoveryListViewWireframe
    let detailViewWireframe: DetailViewWireframe
}

class NavigatorDiscoveryCoordinator {

    typealias Dependencies = HasNavigator & HasDiscoveryListViewWireframe & HasDetailViewWireframe

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

extension NavigatorDiscoveryCoordinator: DiscoveryListViewDelegate {

    private func pushListView() {
        let view = dependencies.discoveryListViewWireframe.make()
        view.delegate = self
        self.discoveryListView = view
        dependencies.navigator.push(view: view)
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

extension NavigatorDiscoveryCoordinator {

    private func pushDetailView(forClassifiedAdID classifiedAdID: ClassifiedAdID) {
        discoveryInteractor.fetchDetail(for: classifiedAdID) { [weak self] ad in
            guard let ad = ad else { preconditionFailure() }
            self?.pushDetailView(forAd: ad)
        }
    }

    private func pushDetailView(forAd ad: ClassifiedAd) {
        let detailView = dependencies.detailViewWireframe.make()
        detailView.viewData = discoveryDetailFormatter.prepare(ad: ad)
        dependencies.navigator.push(view: detailView)
    }
}

extension NavigatorDiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    private func startCategorySelection() {
        let coordinator = makeCategorySelectionCoordinator()
        coordinator.delegate = self
        self.categorySelectionCoordinator = coordinator
        coordinator.start()
    }

    private func makeCategorySelectionCoordinator() -> CategorySelectionCoordinator {
        let wireframe = CategorySelectionListViewControllerWireframe()
        let coordinatorDependencies = CategorySelectionDependencies(
            navigator: dependencies.navigator,
            categorySelectionListViewWireframe: wireframe
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
        categorySelectionCoordinator = nil
    }
}
