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
        let categorySelectionFeature: CategorySelectionFeature
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

    private func updateListView(withAds ads: [Advert], categories: [Category]) {
        let viewData = dependencies.discoveryListFormatter.prepare(ads: ads, categories: categories)
        discoveryListView?.viewData = viewData
    }

    func didSelect(advertID: AdvertID) {
        dependencies.discoveryInteractor.fetchDetail(for: advertID) { ad in
            guard let ad = ad else { preconditionFailure() }
            configureDetailView(with: ad)
        }
    }

    private func configureDetailView(with ad: Advert) {
        let detailView = dependencies.detailViewFactory.make()
        detailView.viewData = dependencies.detailFormatter.prepare(ad: ad)
        dependencies.splitCoordinator.detail = detailView
    }

    // TODO: consider making a popover coordinator to abstract these details.

    func doesWantFilters() {
        let selectionNavigationCoordinator = dependencies.navigationCoordinatorFactory.make()
        let categorySelectionCoordinator = dependencies.categorySelectionFeature.makeCoordinatorUsing(navigationCoordinator: selectionNavigationCoordinator)
        categorySelectionCoordinator.delegate = self
        self.categorySelectionCoordinator = categorySelectionCoordinator
        categorySelectionCoordinator.start()
        listNavigationCoordinator.present(view: selectionNavigationCoordinator)
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
