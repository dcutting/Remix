//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

protocol CategorySelectionCoordinatorDelegate: class {
    func didSelect(categoryID: CategoryID?)
    func didCancelSelection()
}

class CategorySelectionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let categorySelectionViewFactory: CategorySelectionViewFactory
        let interactor: CategorySelectionInteractor
        let formatter: CategorySelectionFormatter
    }

    private let deps: Dependencies
    weak var delegate: CategorySelectionCoordinatorDelegate?

    private var rootView: CategorySelectionView?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        rootView = pushAndUpdateView()
    }

    @discardableResult private func pushAndUpdateView(for categoryID: CategoryID? = nil) -> CategorySelectionView {
        let view = deps.categorySelectionViewFactory.make()
        view.delegate = self
        deps.navigationWireframe.push(view: view)
        update(view: view, for: categoryID)
        return view
    }

    private func update(view: CategorySelectionView, for parentCategoryID: CategoryID?) {
        deps.interactor.fetchCategories(parentCategoryID: parentCategoryID) { categories in
            let viewData = deps.formatter.prepare(categories: categories)
            view.viewData = viewData
        }
    }
}

extension CategorySelectionCoordinator: CategorySelectionViewDelegate {

    func didSelect(categoryID: CategoryID) {
        deps.interactor.findSelectionType(for: categoryID) { selectionType in
            switch selectionType {
            case .leafCategory:
                delegate?.didSelect(categoryID: categoryID)
            case .parentCategory:
                pushAndUpdateView(for: categoryID)
            case .notFound:
                delegate?.didCancelSelection()
            }
        }
    }

    func didDeselectAll() {
        delegate?.didSelect(categoryID: nil)
    }

    func didAbortSelection(fromView: CategorySelectionView) {
        if fromView === rootView {
            delegate?.didCancelSelection()
        }
    }
}
