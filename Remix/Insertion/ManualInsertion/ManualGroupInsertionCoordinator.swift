//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity
import GroupSelection

class ManualGroupInsertionCoordinator: InsertionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let insertionInteractor: InsertionInteractor
        let titleStepFormatter: TitleStepFormatter
        let textEntryStepViewFactory: TextEntryStepViewFactory
        let groupSelectionFeature: GroupSelectionFeature
    }

    public weak var delegate: InsertionCoordinatorDelegate?

    private let deps: Dependencies
    private var groupSelectionCoordinator: GroupSelectionCoordinator?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        startGroupSelection()
    }
}

extension ManualGroupInsertionCoordinator: GroupSelectionCoordinatorDelegate {

    private func startGroupSelection() {
        let coordinator = deps.groupSelectionFeature.makeCoordinatorUsing(navigationWireframe: deps.navigationWireframe)
        coordinator.delegate = self
        groupSelectionCoordinator = coordinator
        coordinator.start()
        deps.navigationWireframe.setPopCheckpoint()
    }

    func didSelect(groupID: GroupID?) {
        if let groupID = groupID {
            updateDraft(groupID: groupID)
            pushTitleStep()
        } else {
            popToGroupSelectionRoot()
        }
    }

    private func updateDraft(groupID: GroupID) {
        deps.insertionInteractor.update(groupID: groupID)
    }

    private func popToGroupSelectionRoot() {
        deps.navigationWireframe.popToLastCheckpoint()
        deps.navigationWireframe.setPopCheckpoint()
    }

    func didCancelSelection() {
    }
}

extension ManualGroupInsertionCoordinator: TextEntryStepViewDelegate {

    private func pushTitleStep() {
        let view = deps.textEntryStepViewFactory.make()
        view.delegate = self
        let draft = deps.insertionInteractor.draft
        view.viewData = deps.titleStepFormatter.prepare(draft: draft)
        deps.navigationWireframe.push(view: view)
    }

    func didTapNext(withText text: String) {
        updateDraft(title: text)
        publishDraft()
    }

    func didGoBack(withText text: String) {
        updateDraft(title: text)
    }

    private func updateDraft(title: String) {
        deps.insertionInteractor.update(title: title)
    }
}

extension ManualGroupInsertionCoordinator {

    private func publishDraft() {
        deps.insertionInteractor.publish { advertID in
            self.finishInsertion(advertID: advertID)
        }
    }

    private func finishInsertion(advertID: AdvertID) {
        deps.navigationWireframe.unsetPopCheckpoint()
        delegate?.didPublishAdvert(advertID: advertID)
    }
}
