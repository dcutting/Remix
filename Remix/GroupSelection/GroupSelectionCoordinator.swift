//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity
import Wireframe

protocol GroupSelectionCoordinatorDelegate: class {
    func didSelect(groupID: GroupID?)
    func didCancelSelection()
}

class GroupSelectionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let groupSelectionViewFactory: GroupSelectionViewFactory
        let interactor: GroupSelectionInteractor
        let formatter: GroupSelectionFormatter
    }

    private let deps: Dependencies
    weak var delegate: GroupSelectionCoordinatorDelegate?

    private var rootView: GroupSelectionView?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        rootView = pushAndUpdateView()
    }

    @discardableResult private func pushAndUpdateView(for groupID: GroupID? = nil) -> GroupSelectionView {
        let view = deps.groupSelectionViewFactory.make()
        view.delegate = self
        deps.navigationWireframe.push(view: view)
        update(view: view, for: groupID)
        return view
    }

    private func update(view: GroupSelectionView, for parentGroupID: GroupID?) {
        deps.interactor.fetchGroups(parentGroupID: parentGroupID) { groups in
            let viewData = deps.formatter.prepare(groups: groups)
            view.viewData = viewData
        }
    }
}

extension GroupSelectionCoordinator: GroupSelectionViewDelegate {

    func didSelect(groupID: GroupID) {
        deps.interactor.findSelectionType(for: groupID) { selectionType in
            switch selectionType {
            case .leafGroup:
                delegate?.didSelect(groupID: groupID)
            case .parentGroup:
                pushAndUpdateView(for: groupID)
            case .notFound:
                delegate?.didCancelSelection()
            }
        }
    }

    func didDeselectAll() {
        delegate?.didSelect(groupID: nil)
    }

    func didAbortSelection(fromView: GroupSelectionView) {
        if fromView === rootView {
            delegate?.didCancelSelection()
        }
    }
}
