//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity
import GroupSelection

class NavigationDiscoveryCoordinator {

    struct Dependencies {

        let navigationWireframe: NavigationWireframe

        let interactor: DiscoveryInteractor
        let detailFormatter: AdvertDetailFormatter
        let detailViewFactory: ItemDetailViewFactory

        let advertListFeature: AdvertListFeature
        let groupSelectionFeature: GroupSelectionFeature
    }

    private let deps: Dependencies
    private var advertListCoordinator: AdvertListCoordinator?
    private var groupSelectionCoordinator: GroupSelectionCoordinator?

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
        deps.interactor.fetchDetail(for: advertID) { advert in
            guard let advert = advert else { preconditionFailure() }
            self.pushDetailView(for: advert)
        }
    }

    private func pushDetailView(for advert: Advert) {
        let detailView = deps.detailViewFactory.make()
        detailView.viewData = deps.detailFormatter.prepare(advert: advert)
        deps.navigationWireframe.push(view: detailView)
    }

    func doesWantFilters() {
        startGroupSelection()
    }
}

extension NavigationDiscoveryCoordinator: GroupSelectionCoordinatorDelegate {

    private func startGroupSelection() {
        let coordinator = deps.groupSelectionFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        groupSelectionCoordinator = coordinator
        deps.navigationWireframe.setPopCheckpoint()
        coordinator.start()
    }

    func didSelect(groupID: GroupID?) {
        advertListCoordinator?.updateAdverts(for: groupID)
        finishGroupSelection()
    }

    func didCancelSelection() {
        finishGroupSelection()
    }

    private func finishGroupSelection() {
        deps.navigationWireframe.popToLastCheckpoint()
        groupSelectionCoordinator = nil
    }
}
