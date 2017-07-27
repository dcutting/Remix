//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

protocol GroupSelectionFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> GroupSelectionCoordinator
}
