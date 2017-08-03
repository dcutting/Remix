//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Service
import GroupSelectionFeature

class AlternatingInsertionFeature: InsertionFeature {

    struct Dependencies {
        let subfeatures: [InsertionFeature]
    }

    private let deps: Dependencies
    private var currentSubfeatureIndex = 0

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> InsertionCoordinator {
        let feature = pickNextFeature()
        return feature.makeCoordinatorUsing(navigationWireframe: navigationWireframe)
    }

    private func pickNextFeature() -> InsertionFeature {
        defer {
            currentSubfeatureIndex = (currentSubfeatureIndex + 1) % deps.subfeatures.count
        }
        return deps.subfeatures[currentSubfeatureIndex]
    }
}
