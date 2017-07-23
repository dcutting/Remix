//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitDiscoveryCoordinator {

    var splitCoordinator: SplitCoordinator
    let discoveryInteractor = DiscoveryInteractor()
    let discoveryListFormatter = DiscoveryListFormatter()
    let discoveryDetailFormatter = DiscoveryDetailFormatter()
    var discoveryListView: DiscoveryListViewController?
    let listNavigationCoordinator = UINavigationCoordinator()
    var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(splitCoordinator: SplitCoordinator) {
        self.splitCoordinator = splitCoordinator
        self.splitCoordinator.master = listNavigationCoordinator
    }

    func start() {
        let listView = DiscoveryListViewController()
        listView.delegate = self
        listNavigationCoordinator.push(view: listView)
        self.discoveryListView = listView
        updateListView()
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
}

extension SplitDiscoveryCoordinator: DiscoveryListViewDelegate {

    func didSelect(classifiedAdID: ClassifiedAdID) {
        discoveryInteractor.fetchDetail(for: classifiedAdID) { ad in
            guard let ad = ad else { preconditionFailure() }
            let detailView = DetailViewControllerWireframe().make()
            detailView.viewData = discoveryDetailFormatter.prepare(ad: ad)
            splitCoordinator.detail = detailView
        }
    }

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
        categorySelectionCoordinator = nil
        listNavigationCoordinator.viewController?.dismiss(animated: true)
    }
}
