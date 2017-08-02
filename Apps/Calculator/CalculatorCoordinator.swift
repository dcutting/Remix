//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class CalculatorCoordinator {

    let interactor = CalculatorInteractor()
    let formatter = CalculatorFormatter()
    var view: CalculatorViewController?

    func start() {
        view = makeCalculatorView()
        view?.delegate = self
    }
}

extension CalculatorCoordinator: CalculatorViewDelegate {

    func viewReady() {
        updateView(result: interactor.result)
    }

    func didChange(first: String) {
        let result = interactor.update(augend: first)
        updateView(result: result)
    }

    func didChange(second: String) {
        let result = interactor.update(addend: second)
        updateView(result: result)
    }

    private func updateView(result: CalculatorInteractor.Result) {
        let viewData = formatter.prepare(result: result)
        view?.viewData = viewData
    }

    func didTapAbout() {
        showAbout()
    }

    private func showAbout() {
        let about = makeAboutView()
        view?.present(about, animated: true)
    }
}

extension CalculatorCoordinator {

    private func makeCalculatorView() -> CalculatorViewController {
        let storyboard = UIStoryboard(name: "CalculatorViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? CalculatorViewController else { preconditionFailure() }
        return viewController
    }

    private func makeAboutView() -> UIViewController {
        let alert = UIAlertController(title: "Calculator", message: "Built with Remix architecture", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        return alert
    }
}
