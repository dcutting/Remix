//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitDiscoveryCoordinator {

    var splitCoordinator: SplitCoordinator
    let discoveryInteractor = DiscoveryInteractor()
    let discoveryListViewWireframe = DiscoveryListViewControllerWireframe()
    let discoveryListFormatter = DiscoveryListFormatter()
    let detailViewWireframe = DetailViewControllerWireframe()
    let detailFormatter = DiscoveryDetailFormatter()

    var discoveryListView: DiscoveryListView?
    let listNavigationCoordinator = UINavigationCoordinator()
    var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(splitCoordinator: SplitCoordinator) {
        self.splitCoordinator = splitCoordinator
        self.splitCoordinator.master = listNavigationCoordinator
    }

    func start() {
        pushListView()
        updateListView()
    }
}

extension SplitDiscoveryCoordinator: DiscoveryListViewDelegate {

    // TODO: consider pulling out the list to its own coordinator since there is a fair amount
    // of duplicate code from the NavigationDiscoveryCoordinator.

    private func pushListView() {
        let view = discoveryListViewWireframe.make()
        view.delegate = self
        self.discoveryListView = view
        listNavigationCoordinator.push(view: view)
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
        discoveryInteractor.fetchDetail(for: classifiedAdID) { ad in
            guard let ad = ad else { preconditionFailure() }
            let detailView = detailViewWireframe.make()
            detailView.viewData = detailFormatter.prepare(ad: ad)
            splitCoordinator.detail = detailView
        }
    }

    // TODO: consider making a popover coordinator to abstract these details.

    func doesWantFilters() {
        let selectionNavigationCoordinator = UINavigationCoordinator()
        selectionNavigationCoordinator.viewController?.modalPresentationStyle = .popover
        let categorySelectionCoordinator = makeCategorySelectionCoordinator(navigationCoordinator: selectionNavigationCoordinator)
        categorySelectionCoordinator.delegate = self
        self.categorySelectionCoordinator = categorySelectionCoordinator
        listNavigationCoordinator.viewController?.present(selectionNavigationCoordinator.viewController!, animated: true)
        selectionNavigationCoordinator.viewController?.popoverPresentationController?.sourceView = selectionNavigationCoordinator.viewController?.view
        categorySelectionCoordinator.start()
    }

    private func makeCategorySelectionCoordinator(navigationCoordinator: NavigationCoordinator) -> CategorySelectionCoordinator {
        let wireframe = CategorySelectionListViewControllerWireframe()
        let coordinatorDependencies = CategorySelectionDependencies(
            navigationCoordinator: navigationCoordinator,
            categorySelectionListViewWireframe: wireframe
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
