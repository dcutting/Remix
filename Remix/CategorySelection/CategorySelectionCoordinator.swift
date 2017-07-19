//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategorySelectionCoordinatorDelegate: class {
    func didSelectCategory(id: CategoryID?)
}

struct CategorySelectionDependencies: CategorySelectionCoordinator.Dependencies {
    let navigator: Navigator
    let selectionListViewWireframe: SelectionListViewWireframe
}

class CategorySelectionCoordinator {

    typealias Dependencies = HasNavigator & HasSelectionListViewWireframe

    private let dependencies: Dependencies
    private var selectionListView: SelectionListView?
    private let categorySelectionInteractor = CategorySelectionInteractor()
    private var listData: [Category]?

    weak var delegate: CategorySelectionCoordinatorDelegate?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        dependencies.navigator.setPopPoint()
        pushSelectionList(for: nil)
    }

    private func pushSelectionList(for categoryID: CategoryID?) {
        var selectionListView = dependencies.selectionListViewWireframe.make()
        selectionListView.delegate = self
        self.selectionListView = selectionListView
        dependencies.navigator.push(view: selectionListView)
        updateSelectionListView(parentCategoryID: categoryID)
    }

    private func updateSelectionListView(parentCategoryID: CategoryID?) {
        categorySelectionInteractor.fetchCategories(parentCategoryID: parentCategoryID) { [weak self] categories in
            let viewData = CategorySelectionListFormatter().prepare(categories: categories)
            self?.selectionListView?.viewData = viewData
            self?.listData = categories
        }
    }
}

extension CategorySelectionCoordinator: SelectionListViewDelegate {

    func didSelectItem(at index: Int) {
        guard let category = listData?[index] else { preconditionFailure() }
        if category.children.isEmpty {
            dependencies.navigator.pop()
            delegate?.didSelectCategory(id: category.categoryID)
        } else {
            pushSelectionList(for: category.categoryID)
        }
    }

    func didResetSelection() {
        dependencies.navigator.pop()
        delegate?.didSelectCategory(id: nil)
    }
}
