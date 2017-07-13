//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategorySelectionCoordinatorDelegate {

    func didSelectCategory(id: CategoryID)
}

class CategorySelectionCoordinator {

    func start() {
    }
}

extension CategorySelectionCoordinator: SelectionListViewDelegate {

    func didSelectItem(at: Int) {
    }
}
