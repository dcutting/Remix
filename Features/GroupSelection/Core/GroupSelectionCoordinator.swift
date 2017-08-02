//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

public protocol GroupSelectionCoordinatorDelegate: class {
    func didSelect(groupID: GroupID?)
    func didCancelSelection()
}

public class GroupSelectionCoordinator {

    public struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let groupSelectionViewFactory: GroupSelectionViewFactory
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
        deps.interactor.fetchGroups(parentGroupID: parentGroupID) { result in
            switch result {
            case let .success(groups):
                let viewData = self.deps.formatter.prepare(groups: groups)
                view.viewData = viewData
            case .error:
                self.showErrorToast()
            }
        }
    }

    private func showErrorToast() {
        print("could not load child groups")  // See AutoGroupInsertionCoordinator example
    }
}

extension GroupSelectionCoordinator: GroupSelectionViewDelegate {

    public func didSelect(groupID: GroupID) {
        deps.interactor.findSelectionType(for: groupID) { result in
            switch result {
            case let .success(selectionType):
                switch selectionType {
                case .leafGroup:
                    self.delegate?.didSelect(groupID: groupID)
                case .parentGroup:
                    self.pushAndUpdateView(for: groupID)
                }
            case .error:
                self.delegate?.didCancelSelection()
            }
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
