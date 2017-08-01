//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe

protocol InsertionFeature {
    func makeCoordinatorUsing(navigationWireframe: NavigationWireframe) -> InsertionCoordinator
}
