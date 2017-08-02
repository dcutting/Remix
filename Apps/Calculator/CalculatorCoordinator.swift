//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class CalculatorCoordinator {

    let service = CalculatorService()
    let interactor: CalculatorInteractor
    let formatter = CalculatorFormatter()
    var view: CalculatorViewController?

    init() {
        interactor = CalculatorInteractor(service: service)
    }

    func start() {
        view = makeCalculatorView()
        view?.delegate = self
    }

    private func makeCalculatorView() -> CalculatorViewController {
        let storyboard = UIStoryboard(name: "CalculatorViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? CalculatorViewController else { preconditionFailure() }
        return viewController
    }
}

extension CalculatorCoordinator: CalculatorViewDelegate {

    func viewReady() {
        updateView(result: interactor.result)
    }

    func didChange(first: String) {
        let result = interactor.update(first: first)
        updateView(result: result)
    }

    func didChange(second: String) {
        let result = interactor.update(second: second)
        updateView(result: result)
    }

    private func updateView(result: CalculatorInteractor.Result) {
        let viewData = formatter.prepare(result: result)
        view?.viewData = viewData
    }
}
