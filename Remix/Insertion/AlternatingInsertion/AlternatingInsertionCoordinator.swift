//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

class AlternatingInsertionCoordinator: InsertionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let subFeatures: [InsertionFeature]
    }

    weak var delegate: InsertionCoordinatorDelegate?

    private let deps: Dependencies
    private var coordinator: InsertionCoordinator?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        let index = Int(arc4random()) % deps.subFeatures.count
        let feature = deps.subFeatures[index]
        coordinator = feature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator?.delegate = self
        coordinator?.start()
    }
}

extension AlternatingInsertionCoordinator: InsertionCoordinatorDelegate {

    func didPublishAdvert(advertID: AdvertID) {
        delegate?.didPublishAdvert(advertID: advertID)
    }
}
