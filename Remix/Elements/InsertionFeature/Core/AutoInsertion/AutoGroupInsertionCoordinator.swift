//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe
import Entity

class AutoGroupInsertionCoordinator: InsertionCoordinator {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let toastWireframeFactory: ToastWireframeFactory
        let insertionInteractor: AutoGroupInsertionInteractor
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
        view.viewData = deps.titleStepFormatter.prepare(draft: deps.insertionInteractor.draft)
        deps.navigationWireframe.push(view: view)
    }
}

extension AutoGroupInsertionCoordinator: TextEntryStepViewDelegate {

    func didTapNext(withText text: String) {
        showLoading()
        deps.insertionInteractor.update(title: text) {
            self.hideLoading()
            self.finishInsertion()
        }
    }

    private func showLoading() {
        let toast = deps.toastWireframeFactory.make(message: "Autoselecting group...")
        deps.navigationWireframe.present(view: toast)
    }

    private func hideLoading() {
        deps.navigationWireframe.dismiss()
    }

    func didGoBack(withText text: String) {
        delegate?.didCancelInsertion()
    }
}

extension AutoGroupInsertionCoordinator {

    private func finishInsertion() {
        deps.insertionInteractor.publish { result in
            switch result {
            case let .success(advertID):
                self.delegate?.didPublishAdvert(advertID: advertID)
            case .error:
                self.showErrorToast()
            }
        }
    }

    private func showErrorToast() {
        let toast = deps.toastWireframeFactory.make(message: "Could not publish advert")
        deps.navigationWireframe.present(view: toast, forSeconds: 2)
    }
}
