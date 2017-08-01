//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe

class ManualGroupInsertionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let insertionInteractor: InsertionInteractor
        let titleStepFormatter: TitleStepFormatter
        let titleStepViewFactory: TitleStepViewFactory
    }

    private let deps: Dependencies
    private var titleStepView: TitleStepView?

    init(dependencies: Dependencies) {
        deps = dependencies
    }

    func start() {
        startTitleStep()
    }

    private func startTitleStep() {
        let view = deps.titleStepViewFactory.make()
        view.delegate = self
        let draft = deps.insertionInteractor.draft
        view.viewData = deps.titleStepFormatter.prepare(draft: draft)
        titleStepView = view
        deps.navigationWireframe.push(view: view)
    }
}

extension ManualGroupInsertionCoordinator: TitleStepViewDelegate {

    func didTapNext(withTitle title: String) {
        deps.insertionInteractor.update(title: title)
    }

    func didGoBack() {
    }
}
