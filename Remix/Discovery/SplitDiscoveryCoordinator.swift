//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SplitDiscoveryCoordinator {

    struct Dependencies {

        var splitWireframe: SplitWireframe

        let discoveryInteractor = DiscoveryInteractor()
        let discoveryListFormatter = DiscoveryListFormatter()
        let detailFormatter = DiscoveryDetailFormatter()

        let navigationWireframeFactory: NavigationWireframeFactory
        let discoveryListViewFactory: DiscoveryListViewFactory
        let detailViewFactory: DetailViewFactory
        let categorySelectionFeature: CategorySelectionFeature
    }

    private var dependencies: Dependencies
    private var discoveryListView: DiscoveryListView?
    private let listNavigationWireframe: NavigationWireframe
    private var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        listNavigationWireframe = dependencies.navigationWireframeFactory.make()
    }

    func start() {
        configureMasterView()
        pushListView()
        updateListView()
    }

    private func configureMasterView() {
        dependencies.splitWireframe.master = listNavigationWireframe
    }
}

extension SplitDiscoveryCoordinator: DiscoveryListViewDelegate {

    // TODO: consider pulling out the list to its own coordinator since there is a fair amount
    // of duplicate code from the NavigationDiscoveryCoordinator.

    private func pushListView() {
        let view = dependencies.discoveryListViewFactory.make()
        view.delegate = self
        self.discoveryListView = view
        listNavigationWireframe.push(view: view)
    }

    private func updateListView(forSelectedCategoryID selectedCategoryID: CategoryID? = nil) {
        dependencies.discoveryInteractor.update(selectedCategoryID: selectedCategoryID) { [weak self] (adverts, categories) in
            self?.updateListView(with: adverts, categories: categories)
        }
    }

    private func updateListView(with adverts: [Advert], categories: [Category]) {
        let viewData = dependencies.discoveryListFormatter.prepare(adverts: adverts, categories: categories)
        discoveryListView?.viewData = viewData
    }

    func didSelect(advertID: AdvertID) {
        dependencies.discoveryInteractor.fetchDetail(for: advertID) { advert in
            guard let advert = advert else { preconditionFailure() }
            configureDetailView(with: advert)
        }
    }

    private func configureDetailView(with advert: Advert) {
        let detailView = dependencies.detailViewFactory.make()
        detailView.viewData = dependencies.detailFormatter.prepare(advert: advert)
        dependencies.splitWireframe.detail = detailView
    }

    // TODO: consider making a popover coordinator to abstract these details.

    func doesWantFilters() {
        let selectionNavigationWireframe = dependencies.navigationWireframeFactory.make()
        let categorySelectionCoordinator = dependencies.categorySelectionFeature.makeCoordinatorUsing(navigationWireframe: selectionNavigationWireframe)
        categorySelectionCoordinator.delegate = self
        self.categorySelectionCoordinator = categorySelectionCoordinator
        categorySelectionCoordinator.start()
        listNavigationWireframe.present(view: selectionNavigationWireframe)
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
        listNavigationWireframe.viewController?.dismiss(animated: true)
        categorySelectionCoordinator = nil
    }
}
