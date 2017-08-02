//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

public protocol GroupSelectionCoordinatorDelegate: class {
    func didSelect(groupID: GroupID?)
    func didCancelSelection()
}

public class GroupSelectionCoordinator {

    public struct Dependencies {
        let navigator: NavigationWireframe
        let viewFactory: GroupSelectionViewFactory
        let interactor: GroupSelectionInteractor
        let formatter: GroupSelectionFormatter
    }

    private let deps: Dependencies
    public weak var delegate: GroupSelectionCoordinatorDelegate?

    private var rootView: GroupSelectionView?

    public init(dependencies: Dependencies) {
        deps = dependencies
    }

    public func start() {
        pushRootGroupView()
    }
}

extension GroupSelectionCoordinator: GroupSelectionViewDelegate {

    public func pushRootGroupView() {
        rootView = pushGroupView(groupID: nil)
    }

    @discardableResult private func pushGroupView(groupID: GroupID?) -> GroupSelectionView {
        let view = deps.viewFactory.make()
        view.delegate = self
        deps.navigator.push(view: view)
        update(view: view, for: groupID)
        return view
    }

    private func update(view: GroupSelectionView, for groupID: GroupID?) {
        deps.interactor.fetchGroups(parentGroupID: groupID) { result in
            switch result {
            case let .success(groups):
                self.update(view: view, groups: groups)
            case .error:
                self.presentError()
            }
        }
    }

    private func update(view: GroupSelectionView, groups: [Group]) {
        let viewData = deps.formatter.prepare(groups: groups)
        view.viewData = viewData
    }

    private func presentError() {
        print("could not load child groups")  // See AutoGroupInsertionCoordinator example
    }

    public func didSelect(groupID: GroupID) {
        selectLeafOrViewChildren(groupID: groupID)
    }

    private func selectLeafOrViewChildren(groupID: GroupID) {
        deps.interactor.findSelectionType(for: groupID) { result in
            switch result {
            case let .success(selectionType):
                self.selectLeafOrViewChildren(groupID: groupID, selectionType: selectionType)
            case .error:
                self.delegate?.didCancelSelection()
            }
        }
    }

    private func selectLeafOrViewChildren(groupID: GroupID, selectionType: GroupSelectionInteractor.SelectionType) {
        switch selectionType {
        case .leafGroup:
            delegate?.didSelect(groupID: groupID)
        case .parentGroup:
            pushGroupView(groupID: groupID)
        }
    }

    public func didDeselectAll() {
        delegate?.didSelect(groupID: nil)
    }

    public func didAbortSelection(fromView: GroupSelectionView) {
        if fromView === rootView {
            delegate?.didCancelSelection()
        }
    }
}
