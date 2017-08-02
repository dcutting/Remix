//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

protocol AdvertListCoordinatorDelegate: class {
    func didSelect(advertID: AdvertID)
    func didSelectNewAdvertAction()
    func didSelectFiltersAction()
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
        reloadAdverts()
    }

    private func pushListView() {
        let view = deps.viewFactory.make()
        view.delegate = self
        self.view = view
        deps.navigationWireframe.push(view: view)
    }

    func reloadAdverts() {
        deps.interactor.refetchFilteredAdverts { (adverts, groups) in
            self.updateListView(with: adverts, groups: groups)
        }
    }

    func updateAdverts(for groupID: GroupID?) {
        deps.interactor.updateFilter(for: groupID) { (adverts, groups) in
            self.updateListView(with: adverts, groups: groups)
        }
    }

    private func updateListView(with adverts: [Advert], groups: [Group]) {
        let viewData = deps.formatter.prepare(adverts: adverts, groups: groups)
        view?.viewData = viewData
    }
}

extension AdvertListCoordinator: AdvertListViewDelegate {

    func didSelect(advertID: AdvertID) {
        delegate?.didSelect(advertID: advertID)
    }

    func didSelectNewAdvertAction() {
        delegate?.didSelectNewAdvertAction()
    }

    func didSelectFiltersAction() {
        delegate?.didSelectFiltersAction()
    }
}
