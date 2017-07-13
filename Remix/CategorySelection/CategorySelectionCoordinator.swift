//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategorySelectionCoordinatorDelegate: class {

    func didSelectCategory(id: CategoryID)
}

class CategorySelectionCoordinator {

    weak var delegate: CategorySelectionCoordinatorDelegate?

    let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func start() {
    }
}

extension CategorySelectionCoordinator: SelectionListViewDelegate {

    func didSelectItem(at index: Int) {
        let categoryID = "1"
        delegate?.didSelectCategory(id: categoryID)
    }
}
