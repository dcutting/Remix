//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategorySelectionCoordinatorDelegate: class {
    func didSelect(categoryID: CategoryID?)
    func didCancelSelection()
}

class CategorySelectionCoordinator {

    struct Dependencies {
        let navigationCoordinator: NavigationCoordinator
        let categorySelectionListViewFactory: CategorySelectionListViewFactory
        let interactor: CategorySelectionInteractor
        let formatter: CategorySelectionListFormatter
    }

    private let dependencies: Dependencies
    weak var delegate: CategorySelectionCoordinatorDelegate?

    private var rootCategorySelectionListView: CategorySelectionListView?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        rootCategorySelectionListView = pushAndUpdateCategorySelectionList()
    }

    @discardableResult private func pushAndUpdateCategorySelectionList(for categoryID: CategoryID? = nil) -> CategorySelectionListView {
        let categorySelectionListView = dependencies.categorySelectionListViewFactory.make()
        categorySelectionListView.delegate = self
        dependencies.navigationCoordinator.push(view: categorySelectionListView)
        update(categorySelectionListView: categorySelectionListView, parentCategoryID: categoryID)
        return categorySelectionListView
    }

    private func update(categorySelectionListView: CategorySelectionListView, parentCategoryID: CategoryID?) {
        let view = categorySelectionListView
        dependencies.interactor.fetchCategories(parentCategoryID: parentCategoryID) { categories in
            let viewData = dependencies.formatter.prepare(categories: categories)
            view.viewData = viewData
        }
    }
}

extension CategorySelectionCoordinator: CategorySelectionListViewDelegate {

    func didSelect(categoryID: CategoryID) {
        dependencies.interactor.findSelectionType(for: categoryID) { selectionType in
            switch selectionType {
            case .leafCategory:
                delegate?.didSelect(categoryID: categoryID)
            case .parentCategory:
                pushAndUpdateCategorySelectionList(for: categoryID)
            }
        }
    }

    func didDeselectAll() {
        delegate?.didSelect(categoryID: nil)
    }

    func didAbortSelection(view: CategorySelectionListView) {
        if view === rootCategorySelectionListView {
            delegate?.didCancelSelection()
        }
    }
}
