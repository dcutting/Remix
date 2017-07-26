//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SplitDiscoveryCoordinator {

    struct Dependencies {

        var splitWireframe: SplitWireframe

        let interactor: DiscoveryInteractor
        let listFormatter: AdvertListFormatter
        let detailFormatter: DiscoveryDetailFormatter

        let navigationWireframeFactory: NavigationWireframeFactory
        let listViewFactory: AdvertListViewFactory
        let detailViewFactory: AdvertDetailViewFactory
        let categorySelectionFeature: CategorySelectionFeature
    }

    private var deps: Dependencies
    private var listView: AdvertListView?
    private let listNavigationWireframe: NavigationWireframe
    private var categorySelectionCoordinator: CategorySelectionCoordinator?

    init(dependencies: Dependencies) {
        deps = dependencies
        listNavigationWireframe = dependencies.navigationWireframeFactory.make()
    }

    func start() {
        configureMasterView()
        pushListView()
        updateListView()
    }

    private func configureMasterView() {
        deps.splitWireframe.master = listNavigationWireframe
    }
}

extension SplitDiscoveryCoordinator: AdvertListViewDelegate {

    // TODO: consider pulling out the list to its own coordinator since there is a fair amount
    // of duplicate code from the NavigationDiscoveryCoordinator.

    private func pushListView() {
        let view = deps.listViewFactory.make()
        view.delegate = self
        listView = view
        listNavigationWireframe.push(view: view)
    }

    private func updateListView(forSelectedCategoryID selectedCategoryID: CategoryID? = nil) {
        deps.interactor.update(selectedCategoryID: selectedCategoryID) { [weak self] (adverts, categories) in
            self?.updateListView(with: adverts, categories: categories)
        }
    }

    private func updateListView(with adverts: [Advert], categories: [Category]) {
        let viewData = deps.listFormatter.prepare(adverts: adverts, categories: categories)
        listView?.viewData = viewData
    }

    func didSelect(advertID: AdvertID) {
        deps.interactor.fetchDetail(for: advertID) { advert in
            guard let advert = advert else { preconditionFailure() }
            configureDetailView(with: advert)
        }
    }

    private func configureDetailView(with advert: Advert) {
        let detailView = deps.detailViewFactory.make()
        detailView.viewData = deps.detailFormatter.prepare(advert: advert)
        deps.splitWireframe.detail = detailView
    }

    // TODO: consider making a popover coordinator to abstract these details.

    func doesWantFilters() {
        let selectionNavigationWireframe = deps.navigationWireframeFactory.make()
        let coordinator = deps.categorySelectionFeature.makeCoordinatorUsing(navigationWireframe: selectionNavigationWireframe)
        coordinator.delegate = self
        categorySelectionCoordinator = coordinator
        coordinator.start()
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
