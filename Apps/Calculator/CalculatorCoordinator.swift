//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class CalculatorCoordinator {

    let sumInteractor = SumInteractor()
    let sumFormatter = SumFormatter()
    var sumView: SumViewController?

    let primeInteractor = PrimeInteractor()
    let primeFormatter = PrimeFormatter()
    var primeView: PrimeViewController?

    func start() {
        showSumView()
    }
}

extension CalculatorCoordinator: SumViewDelegate {

    func showSumView() {
        sumView = makeSumView()
        sumView?.delegate = self
    }

    func viewReady() {
        updateView(result: sumInteractor.result)
    }

    func didChange(left: String) {
        let result = sumInteractor.update(firstTerm: left)
        updateView(result: result)
    }

    func didChange(right: String) {
        let result = sumInteractor.update(secondTerm: right)
        updateView(result: result)
    }

    private func updateView(result: SumInteractor.Result) {
        let viewData = sumFormatter.prepare(result: result)
        sumView?.viewData = viewData
    }

    func didTapAnalyse() {
        let number = sumInteractor.result.sum
        showPrimeView(number: number)
    }
}

extension CalculatorCoordinator: PrimeViewControllerDelegate {

    private func showPrimeView(number: Int) {
        let view = makePrimeView()
        view.delegate = self
        sumView?.present(view, animated: true)
        primeView = view
        analyseForPrimality(number: number)
    }

    private func analyseForPrimality(number: Int) {
        let result = primeInteractor.isPrime(n: number)
        let viewData = primeFormatter.prepare(result: result)
        primeView?.viewData = viewData
    }

    func didTapOK() {
        sumView?.dismiss(animated: true)
        primeView = nil
    }
}

extension CalculatorCoordinator {

    private func makeSumView() -> SumViewController {
        let storyboard = UIStoryboard(name: "SumViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? SumViewController else { preconditionFailure() }
        return viewController
    }

    private func makePrimeView() -> PrimeViewController {
        let storyboard = UIStoryboard(name: "PrimeViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? PrimeViewController else { preconditionFailure() }
        return viewController
    }
}
