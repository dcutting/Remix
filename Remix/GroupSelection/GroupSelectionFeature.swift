//  Copyright © 2017 cutting.io. All rights reserved.

import Core

protocol GroupSelectionFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> GroupSelectionCoordinator
}
