//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategorySelectionCoordinatorDelegate: class {
    func didSelect(categoryID: CategoryID?)
    func didCancelSelection()
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
    private var rootNavigationID: UUID?

    weak var delegate: CategorySelectionCoordinatorDelegate?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        dependencies.navigator.setPopCheckpoint()
        rootNavigationID = pushCategorySelectionList()
    }

    @discardableResult private func pushCategorySelectionList(for categoryID: CategoryID? = nil) -> UUID {
        var categorySelectionListView = dependencies.categorySelectionListViewWireframe.make()
        categorySelectionListView.delegate = self
        dependencies.navigator.push(view: categorySelectionListView)
        update(categorySelectionListView: categorySelectionListView, parentCategoryID: categoryID)
        return categorySelectionListView.navigationID
    }

    private func update(categorySelectionListView: CategorySelectionListView, parentCategoryID: CategoryID?) {
        var view = categorySelectionListView
        categorySelectionInteractor.fetchCategories(parentCategoryID: parentCategoryID) { categories in
            let viewData = categorySelectionListFormatter.prepare(categories: categories)
            view.viewData = viewData
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

    func didCancelSelection(navigationID: UUID) {
        if navigationID == rootNavigationID {
            delegate?.didCancelSelection()
        }
    }
}
