//  Copyright © 2017 cutting.io. All rights reserved.

class CalculatorCoordinator {

    let sumInteractor = SumInteractor()
    let sumFormatter = SumFormatter()
    let sumViewFactory = SumViewControllerFactory()
    var sumView: SumView?

    let primeInteractor = PrimeInteractor()
    let primeFormatter = PrimeFormatter()
    let primeViewFactory = PrimeViewControllerFactory()
    var primeView: PrimeView?

    func start() {
        showSumView()
    }
}

extension CalculatorCoordinator: SumViewDelegate {

    func showSumView() {
        sumView = sumViewFactory.make()
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

extension CalculatorCoordinator: PrimeViewDelegate {

    private func showPrimeView(number: Int) {

        let view = primeViewFactory.make()
        view.delegate = self
        primeView = view

        sumView?.present(view: view)

        analyseForPrimality(number: number)
    }

    private func analyseForPrimality(number: Int) {
        let result = primeInteractor.isPrime(n: number)
        let viewData = primeFormatter.prepare(result: result)
        primeView?.viewData = viewData
    }

    func didTapOK() {
        sumView?.dismiss()
        primeView = nil
    }
}
