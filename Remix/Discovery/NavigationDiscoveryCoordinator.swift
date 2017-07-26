//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class NavigationDiscoveryCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let discoveryListViewFactory: DiscoveryListViewFactory
        let detailViewFactory: DetailViewFactory
        let categorySelectionFeature: CategorySelectionFeature
    }

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
        dependencies.navigationWireframe.push(view: view)
    }

    private func updateListView(forSelectedCategoryID selectedCategoryID: CategoryID? = nil) {
        discoveryInteractor.update(selectedCategoryID: selectedCategoryID) { [weak self] (adverts, categories) in
            self?.updateListView(with: adverts, categories: categories)
        }
    }

    private func updateListView(with adverts: [Advert], categories: [Category]) {
        let viewData = discoveryListFormatter.prepare(adverts: adverts, categories: categories)
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
        discoveryInteractor.fetchDetail(for: advertID) { [weak self] advert in
            guard let advert = advert else { preconditionFailure() }
            self?.pushDetailView(for: advert)
        }
    }

    private func pushDetailView(for advert: Advert) {
        let detailView = dependencies.detailViewFactory.make()
        detailView.viewData = discoveryDetailFormatter.prepare(advert: advert)
        dependencies.navigationWireframe.push(view: detailView)
    }
}

extension NavigationDiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    private func startCategorySelection() {
        let coordinator = dependencies.categorySelectionFeature.makeCoordinatorUsing(navigationWireframe: dependencies.navigationWireframe)
        coordinator.delegate = self
        self.categorySelectionCoordinator = coordinator
        dependencies.navigationWireframe.setPopCheckpoint()
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
        dependencies.navigationWireframe.popToLastCheckpoint()
        categorySelectionCoordinator = nil
    }
}
