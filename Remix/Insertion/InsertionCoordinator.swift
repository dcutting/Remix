//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity

protocol InsertionCoordinatorDelegate: class {
    func didPublishAdvert(advertID: AdvertID)
    func didCancelInsertion()
}

protocol InsertionCoordinator: class {

    weak var delegate: InsertionCoordinatorDelegate? { get set }
    
    func start()
}
