//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

class AutoGroupInsertionCoordinator: InsertionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let insertionInteractor: InsertionInteractor
        let titleStepFormatter: TitleStepFormatter
        let textEntryStepViewFactory: TextEntryStepViewFactory
    }

    weak var delegate: InsertionCoordinatorDelegate?

    private let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        startTitleStep()
    }
}

extension AutoGroupInsertionCoordinator {

    private func startTitleStep() {
        let view = deps.textEntryStepViewFactory.make()
        view.delegate = self
        deps.navigationWireframe.push(view: view)
    }
}

extension AutoGroupInsertionCoordinator: TextEntryStepViewDelegate {

    func didTapNext(withText text: String) {
        deps.insertionInteractor.update(title: text)
        finishInsertion()
    }

    func didGoBack(withText text: String) {
        deps.insertionInteractor.update(title: text)
    }
}

extension AutoGroupInsertionCoordinator {

    private func finishInsertion() {
        deps.insertionInteractor.publish { advertID in
            self.delegate?.didPublishAdvert(advertID: advertID)
        }
    }
}
