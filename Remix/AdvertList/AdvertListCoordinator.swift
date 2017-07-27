//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Core

protocol AdvertListCoordinatorDelegate: class {
    func didSelect(advertID: AdvertID)
    func doesWantFilters()
}

class AdvertListCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let interactor: AdvertListInteractor
        let formatter: AdvertListFormatter
        let viewFactory: AdvertListViewFactory
    }

    private let deps: Dependencies
    weak var delegate: AdvertListCoordinatorDelegate?

    private var view: AdvertListView?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        pushListView()
        updateListView()
    }

    private func pushListView() {
        let view = deps.viewFactory.make()
        view.delegate = self
        self.view = view
        deps.navigationWireframe.push(view: view)
    }

    private func updateListView() {
        updateAdverts(for: nil)
    }

    func updateAdverts(for categoryID: CategoryID?) {
        deps.interactor.update(for: categoryID) { [weak self] (adverts, categories) in
            self?.updateListView(with: adverts, categories: categories)
        }
    }

    private func updateListView(with adverts: [Advert], categories: [Core.Category]) {
        let viewData = deps.formatter.prepare(adverts: adverts, categories: categories)
        view?.viewData = viewData
    }
}

extension AdvertListCoordinator: AdvertListViewDelegate {

    func didSelect(advertID: AdvertID) {
        delegate?.didSelect(advertID: advertID)
    }

    func doesWantFilters() {
        delegate?.doesWantFilters()
    }
}
