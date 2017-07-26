//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class NavigationDiscoveryCoordinator {

    struct Dependencies {

        let navigationWireframe: NavigationWireframe

        let interactor: DiscoveryInteractor
        let listFormatter: DiscoveryListFormatter
        let detailFormatter: DiscoveryDetailFormatter

        let discoveryListViewFactory: DiscoveryListViewFactory
        let detailViewFactory: DetailViewFactory
        let categorySelectionFeature: CategorySelectionFeature
    }

    private let deps: Dependencies
    private var discoveryListView: DiscoveryListView?
    private var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(dependencies: Dependencies) {
        self.deps = dependencies
    }

    func start() {
        pushListView()
        updateListView()
    }
}

extension NavigationDiscoveryCoordinator: DiscoveryListViewDelegate {

    private func pushListView() {
        let view = deps.discoveryListViewFactory.make()
        view.delegate = self
        self.discoveryListView = view
        deps.navigationWireframe.push(view: view)
    }

    private func updateListView(forSelectedCategoryID selectedCategoryID: CategoryID? = nil) {
        deps.interactor.update(selectedCategoryID: selectedCategoryID) { [weak self] (adverts, categories) in
            self?.updateListView(with: adverts, categories: categories)
        }
    }

    private func updateListView(with adverts: [Advert], categories: [Category]) {
        let viewData = deps.listFormatter.prepare(adverts: adverts, categories: categories)
        discoveryListView?.viewData = viewData
    }

    func didSelect(advertID: AdvertID) {
        pushDetailView(forAdvertID: advertID)
    }

    func doesWantFilters() {
        startCategorySelection()
    }
}

extension NavigationDiscoveryCoordinator {

    private func pushDetailView(forAdvertID advertID: AdvertID) {
        deps.interactor.fetchDetail(for: advertID) { [weak self] advert in
            guard let advert = advert else { preconditionFailure() }
            self?.pushDetailView(for: advert)
        }
    }

    private func pushDetailView(for advert: Advert) {
        let detailView = deps.detailViewFactory.make()
        detailView.viewData = deps.detailFormatter.prepare(advert: advert)
        deps.navigationWireframe.push(view: detailView)
    }
}

extension NavigationDiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    private func startCategorySelection() {
        let coordinator = deps.categorySelectionFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        self.categorySelectionCoordinator = coordinator
        deps.navigationWireframe.setPopCheckpoint()
        coordinator.start()
    }

    func didSelect(categoryID: CategoryID?) {
        updateListView(forSelectedCategoryID: categoryID)
        finishCategorySelection()
    }

    func didCancelSelection() {
        finishCategorySelection()
    }

    private func finishCategorySelection() {
        deps.navigationWireframe.popToLastCheckpoint()
        categorySelectionCoordinator = nil
    }
}
