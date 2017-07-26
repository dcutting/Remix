//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SplitDiscoveryCoordinator {

    struct Dependencies {

        var splitWireframe: SplitWireframe
        let navigationWireframeFactory: NavigationWireframeFactory

        let interactor: DiscoveryInteractor
        let detailFormatter: DiscoveryDetailFormatter
        let detailViewFactory: AdvertDetailViewFactory

        let advertListFeature: AdvertListFeature
        let categorySelectionFeature: CategorySelectionFeature
    }

    private var deps: Dependencies
    private var advertListCoordinator: AdvertListCoordinator?
    private var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        startAdvertList()
    }
}

extension SplitDiscoveryCoordinator: AdvertListCoordinatorDelegate {

    private func startAdvertList() {
        let navigationWireframe = deps.navigationWireframeFactory.make()
        let coordinator = deps.advertListFeature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
        coordinator.delegate = self
        advertListCoordinator = coordinator
        deps.splitWireframe.master = navigationWireframe
        coordinator.start()
    }

    func didSelect(advertID: AdvertID) {
        showDetailView(for: advertID)
    }

    private func showDetailView(for advertID: AdvertID) {
        deps.interactor.fetchDetail(for: advertID) { advert in
            guard let advert = advert else { preconditionFailure() }
            showDetailView(for: advert)
        }
    }

    private func showDetailView(for advert: Advert) {
        let detailView = deps.detailViewFactory.make()
        detailView.viewData = deps.detailFormatter.prepare(advert: advert)
        deps.splitWireframe.detail = detailView
    }

    func doesWantFilters() {
        startCategorySelection()
    }
}

extension SplitDiscoveryCoordinator: CategorySelectionCoordinatorDelegate {

    private func startCategorySelection() {
        let navigationWireframe = deps.navigationWireframeFactory.make()
        let coordinator = deps.categorySelectionFeature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
        coordinator.delegate = self
        categorySelectionCoordinator = coordinator
        coordinator.start()
        deps.splitWireframe.present(view: navigationWireframe)
    }

    func didSelect(categoryID: CategoryID?) {
        advertListCoordinator?.updateAdverts(for: categoryID)
        finishCategorySelection()
    }

    func didCancelSelection() {
        finishCategorySelection()
    }

    private func finishCategorySelection() {
        deps.splitWireframe.dismiss()
        categorySelectionCoordinator = nil
    }
}
