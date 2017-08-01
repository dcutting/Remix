//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

protocol InsertionCoordinatorDelegate: class {
    func didPublishAdvert(advertID: AdvertID)
}

class InsertionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let manualFeature: ManualGroupInsertionFeature
        let autoFeature: AutoGroupInsertionFeature
    }

    weak var delegate: InsertionCoordinatorDelegate?

    private let deps: Dependencies
    private var insertionCoordinator: Any?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        if arc4random() % 2 == 0 {
            startManualFeature()
        } else {
            startAutoFeature()
        }
    }

    private func startManualFeature() {
        let coordinator = deps.manualFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        coordinator.start()
        insertionCoordinator = coordinator
    }

    private func startAutoFeature() {
        let coordinator = deps.autoFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        coordinator.start()
        insertionCoordinator = coordinator
    }
}

extension InsertionCoordinator: ManualGroupInsertionCoordinatorDelegate, AutoGroupInsertionCoordinatorDelegate {

    func didPublishAdvert(advertID: AdvertID) {
        delegate?.didPublishAdvert(advertID: advertID)
    }
}

