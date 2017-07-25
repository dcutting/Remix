//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SplitDiscoveryCoordinator {

    struct Dependencies {

        var splitCoordinator: SplitCoordinator

        let discoveryInteractor = DiscoveryInteractor()
        let discoveryListFormatter = DiscoveryListFormatter()
        let detailFormatter = DiscoveryDetailFormatter()

        let navigationCoordinatorFactory: NavigationCoordinatorFactory
        let discoveryListViewFactory: DiscoveryListViewFactory
        let detailViewFactory: DetailViewFactory
    }

    private var dependencies: Dependencies
    private var discoveryListView: DiscoveryListView?
    private let listNavigationCoordinator: NavigationCoordinator
    private var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        listNavigationCoordinator = dependencies.navigationCoordinatorFactory.make()
    }

    func start() {
        configureMasterView()
        pushListView()
        updateListView()
    }

    private func configureMasterView() {
        dependencies.splitCoordinator.master = listNavigationCoordinator
    }
}

extension SplitDiscoveryCoordinator: DiscoveryListViewDelegate {

    // TODO: consider pulling out the list to its own coordinator since there is a fair amount
    // of duplicate code from the NavigationDiscoveryCoordinator.

    private func pushListView() {
        let view = dependencies.discoveryListViewFactory.make()
        view.delegate = self
        self.discoveryListView = view
        listNavigationCoordinator.push(view: view)
    }

    private func updateListView(forSelectedCategoryID selectedCategoryID: CategoryID? = nil) {
        dependencies.discoveryInteractor.update(selectedCategoryID: selectedCategoryID) { [weak self] (ads, categories) in
            self?.updateListView(withAds: ads, categories: categories)
        }
    }

    private func updateListView(withAds ads: [ClassifiedAd], categories: [Category]) {
        let viewData = dependencies.discoveryListFormatter.prepare(ads: ads, categories: categories)
        discoveryListView?.viewData = viewData
    }

    func didSelect(classifiedAdID: ClassifiedAdID) {
        dependencies.discoveryInteractor.fetchDetail(for: classifiedAdID) { ad in
            guard let ad = ad else { preconditionFailure() }
            configureDetailView(with: ad)
        }
    }

    private func configureDetailView(with ad: ClassifiedAd) {
        let detailView = dependencies.detailViewFactory.make()
        detailView.viewData = dependencies.detailFormatter.prepare(ad: ad)
        dependencies.splitCoordinator.detail = detailView
    }

    // TODO: consider making a popover coordinator to abstract these details.

    func doesWantFilters() {
        let selectionNavigationCoordinator = dependencies.navigationCoordinatorFactory.make()
        let categorySelectionCoordinator = makeCategorySelectionCoordinator(navigationCoordinator: selectionNavigationCoordinator)
        categorySelectionCoordinator.delegate = self
        self.categorySelectionCoordinator = categorySelectionCoordinator
        categorySelectionCoordinator.start()
        listNavigationCoordinator.present(view: selectionNavigationCoordinator)
    }

    // TODO: extract coordinator creation?

    private func makeCategorySelectionCoordinator(navigationCoordinator: NavigationCoordinator) -> CategorySelectionCoordinator {
        let factory = CategorySelectionListViewControllerFactory()
        let coordinatorDependencies = CategorySelectionDependencies(
            navigationCoordinator: navigationCoordinator,
            categorySelectionListViewFactory: factory
        )
        return CategorySelectionCoordinator(dependencies: coordinatorDependencies)
    }
}

extension SplitDiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    func didSelect(categoryID: CategoryID?) {
        updateListView(forSelectedCategoryID: categoryID)
        finishCategorySelection()
    }

    func didCancelSelection() {
        finishCategorySelection()
    }

    private func finishCategorySelection() {
        listNavigationCoordinator.viewController?.dismiss(animated: true)
        categorySelectionCoordinator = nil
    }
}
