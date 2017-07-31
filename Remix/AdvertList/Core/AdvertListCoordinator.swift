//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

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
        updateAdverts()
    }

    private func pushListView() {
        let view = deps.viewFactory.make()
        view.delegate = self
        self.view = view
        deps.navigationWireframe.push(view: view)
    }

    func updateAdverts(for groupID: GroupID? = nil) {
        deps.interactor.update(for: groupID) { (adverts, groups) in
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

    func doesWantFilters() {
        delegate?.doesWantFilters()
    }
}
