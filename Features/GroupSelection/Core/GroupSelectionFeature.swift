//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

public protocol GroupSelectionFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> GroupSelectionCoordinator
}
