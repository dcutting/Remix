//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class NavigationDiscoveryCoordinator {

    struct Dependencies {

        let navigationWireframe: NavigationWireframe

        let interactor: DiscoveryInteractor
        let detailFormatter: DiscoveryDetailFormatter
        let detailViewFactory: AdvertDetailViewFactory

        let advertListFeature: AdvertListFeature
        let categorySelectionFeature: CategorySelectionFeature
    }

    private let deps: Dependencies
    private var advertListCoordinator: AdvertListCoordinator?
    private var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        startAdvertList()
    }
}

extension NavigationDiscoveryCoordinator: AdvertListCoordinatorDelegate {

    func startAdvertList() {
        advertListCoordinator = deps.advertListFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        advertListCoordinator?.delegate = self
        advertListCoordinator?.start()
    }

    func didSelect(advertID: AdvertID) {
        pushDetailView(for: advertID)
    }

    private func pushDetailView(for advertID: AdvertID) {
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

    func doesWantFilters() {
        startCategorySelection()
    }
}

extension NavigationDiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    private func startCategorySelection() {
        let coordinator = deps.categorySelectionFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        categorySelectionCoordinator = coordinator
        deps.navigationWireframe.setPopCheckpoint()
        coordinator.start()
    }

    func didSelect(categoryID: CategoryID?) {
        advertListCoordinator?.updateAdverts(for: categoryID)
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
