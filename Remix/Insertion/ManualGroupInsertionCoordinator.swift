//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity
import GroupSelection

class ManualGroupInsertionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let insertionInteractor: InsertionInteractor
        let titleStepFormatter: TitleStepFormatter
        let textEntryStepViewFactory: TextEntryStepViewFactory
        let groupSelectionFeature: GroupSelectionFeature
    }

    private let deps: Dependencies
    private var groupSelectionCoordinator: GroupSelectionCoordinator?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        startGroupSelection()
    }

    private func startGroupSelection() {
        let coordinator = deps.groupSelectionFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        groupSelectionCoordinator = coordinator
        coordinator.start()
        deps.navigationWireframe.setPopCheckpoint()
    }
}

extension ManualGroupInsertionCoordinator: GroupSelectionCoordinatorDelegate {

    func didSelect(groupID: GroupID?) {
        if let groupID = groupID {
            deps.insertionInteractor.update(groupID: groupID)
            startTitleStep()
        } else {
            deps.navigationWireframe.popToLastCheckpoint()
            deps.navigationWireframe.setPopCheckpoint()
        }
    }

    func didCancelSelection() {
    }
}

extension ManualGroupInsertionCoordinator: TextEntryStepViewDelegate {

    private func startTitleStep() {
        let view = deps.textEntryStepViewFactory.make()
        view.delegate = self
        let draft = deps.insertionInteractor.draft
        view.viewData = deps.titleStepFormatter.prepare(draft: draft)
        deps.navigationWireframe.push(view: view)
    }

    func didTapNext(withText text: String) {
        deps.insertionInteractor.update(title: text)
        pushDescriptionStep()
    }

    private func pushDescriptionStep() {
        startTitleStep()
    }

    func didGoBack() {
        print("went back")
    }
}
