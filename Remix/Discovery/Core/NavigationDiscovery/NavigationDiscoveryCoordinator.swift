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
        let insertionFeature: InsertionFeature
        let groupSelectionFeature: GroupSelectionFeature
    }

    private let deps: Dependencies
    private var advertListCoordinator: AdvertListCoordinator?
    private var insertionCoordinator: InsertionCoordinator?
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
        deps.interactor.fetchDetail(for: advertID) { result in
            switch result {
            case let .success(advert):
                self.pushDetailView(for: advert)
            case .error:
                self.showErrorToast()
            }
        }
    }

    private func pushDetailView(for advert: Advert) {
        let detailView = deps.detailViewFactory.make()
        detailView.viewData = deps.detailFormatter.prepare(advert: advert)
        deps.navigationWireframe.push(view: detailView)
    }

    private func showErrorToast() {
        print("could not load advert details")  // See AutoGroupInsertionCoordinator example
    }

    func didSelectNewAdvertAction() {
        startInsertion()
    }

    func didSelectFiltersAction() {
        startGroupSelection()
    }
}

extension NavigationDiscoveryCoordinator: InsertionCoordinatorDelegate {

    private func startInsertion() {
        let coordinator = deps.insertionFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        insertionCoordinator = coordinator
        deps.navigationWireframe.setPopCheckpoint()
        coordinator.start()
    }

    func didPublishAdvert(advertID: AdvertID) {
        advertListCoordinator?.reloadAdverts()
        finishInsertion()
    }

    func didCancelInsertion() {
        finishInsertion()
    }

    private func finishInsertion() {
        insertionCoordinator = nil
        deps.navigationWireframe.popToLastCheckpoint()
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
