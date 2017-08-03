//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class CalculatorCoordinator {

    let interactor = SumInteractor()
    let formatter = SumFormatter()
    var view: SumViewController?

    func start() {
        view = makeCalculatorView()
        view?.delegate = self
    }
}

extension CalculatorCoordinator: SumViewDelegate {

    func viewReady() {
        updateView(result: interactor.result)
    }

    func didChange(left: String) {
        let result = interactor.update(firstTerm: left)
        updateView(result: result)
    }

    func didChange(right: String) {
        let result = interactor.update(secondTerm: right)
        updateView(result: result)
    }

    private func updateView(result: SumInteractor.Result) {
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

    private func makeCalculatorView() -> SumViewController {
        let storyboard = UIStoryboard(name: "SumViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? SumViewController else { preconditionFailure() }
        return viewController
    }

    private func makeAboutView() -> UIViewController {
        let alert = UIAlertController(title: "Calculator", message: "Built with Remix architecture", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        return alert
    }
}
