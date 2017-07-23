//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SplitDiscoveryCoordinator {

    var splitCoordinator: MasterDetailCoordinator
    let discoveryInteractor = DiscoveryInteractor()
    let discoveryListFormatter = DiscoveryListFormatter()
    let discoveryDetailFormatter = DiscoveryDetailFormatter()
    var discoveryListView: DiscoveryListViewController?
    let listNavigator = NavigatorController()
    var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(splitCoordinator: MasterDetailCoordinator) {
        self.splitCoordinator = splitCoordinator
        self.splitCoordinator.master = listNavigator
    }

    func start() {
        let listView = DiscoveryListViewController()
        listView.delegate = self
        listNavigator.push(view: listView)
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
        let selectionNavigator = NavigatorController()
        selectionNavigator.viewController?.modalPresentationStyle = .popover
        let categorySelectionCoordinator = makeCategorySelectionCoordinator(navigator: selectionNavigator)
        categorySelectionCoordinator.delegate = self
        self.categorySelectionCoordinator = categorySelectionCoordinator
        listNavigator.viewController?.present(selectionNavigator.viewController!, animated: true)
        selectionNavigator.viewController?.popoverPresentationController?.sourceView = selectionNavigator.viewController?.view
        categorySelectionCoordinator.start()
    }

    private func makeCategorySelectionCoordinator(navigator: Navigator) -> CategorySelectionCoordinator {
        let wireframe = CategorySelectionListViewControllerWireframe()
        let coordinatorDependencies = CategorySelectionDependencies(
            navigator: navigator,
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
        listNavigator.viewController?.dismiss(animated: true)
    }
}
