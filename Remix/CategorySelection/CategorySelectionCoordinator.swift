//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategorySelectionCoordinatorDelegate: class {
    func didSelect(categoryID: CategoryID?)
}

struct CategorySelectionDependencies: CategorySelectionCoordinator.Dependencies {
    let navigator: Navigator
    let categorySelectionListViewWireframe: CategorySelectionListViewWireframe
}

class CategorySelectionCoordinator {

    typealias Dependencies = HasNavigator & HasCategorySelectionListViewWireframe

    private let dependencies: Dependencies
    private let categorySelectionInteractor = CategorySelectionInteractor()
    private let categorySelectionListFormatter = CategorySelectionListFormatter()
    private var categorySelectionListView: CategorySelectionListView?

    weak var delegate: CategorySelectionCoordinatorDelegate?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        dependencies.navigator.setPopPoint()
        pushCategorySelectionList()
    }

    private func pushCategorySelectionList(for categoryID: CategoryID? = nil) {
        var selectionListView = dependencies.categorySelectionListViewWireframe.make()
        selectionListView.delegate = self
        self.categorySelectionListView = selectionListView
        dependencies.navigator.push(view: selectionListView)
        updateSelectionListView(parentCategoryID: categoryID)
    }

    private func updateSelectionListView(parentCategoryID: CategoryID?) {
        categorySelectionInteractor.fetchCategories(parentCategoryID: parentCategoryID) { [weak self] categories in
            let viewData = categorySelectionListFormatter.prepare(categories: categories)
            self?.categorySelectionListView?.viewData = viewData
        }
    }
}

extension CategorySelectionCoordinator: CategorySelectionListViewDelegate {

    func didSelect(categoryID: CategoryID) {
        categorySelectionInteractor.selectionType(for: categoryID) { selectionType in
            switch selectionType {
            case .leafCategory:
                dependencies.navigator.pop()
                delegate?.didSelect(categoryID: categoryID)
            case .parentCategory:
                pushCategorySelectionList(for: categoryID)
            }
        }
    }

    func didResetSelection() {
        dependencies.navigator.pop()
        delegate?.didSelect(categoryID: nil)
    }
}
