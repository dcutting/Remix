//  Copyright © 2017 cutting.io. All rights reserved.

import Entity
import Wireframe

protocol GroupSelectionFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> GroupSelectionCoordinator
}
