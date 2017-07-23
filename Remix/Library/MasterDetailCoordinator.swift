//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol MasterDetailCoordinator {
    var master: Navigatable? { get set }
    var detail: Navigatable? { get set }
}
