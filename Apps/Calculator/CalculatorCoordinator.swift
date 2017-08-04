//  Copyright © 2017 cutting.io. All rights reserved.

class CalculatorCoordinator {

    let sumInteractor = SumInteractor()
    let sumFormatter = SumFormatter()
    var sumView: SumView?

    let primeInteractor = PrimeInteractor()
    let primeFormatter = PrimeFormatter()
    var primeView: PrimeView?

    let sumViewFactory: SumViewFactory
    let primeViewFactory: PrimeViewFactory

    init(sumViewFactory: SumViewFactory, primeViewFactory: PrimeViewFactory) {
        self.sumViewFactory = sumViewFactory
        self.primeViewFactory = primeViewFactory
    }

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

        analyseForPrimality(number: number)

        sumView?.present(view: view)
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
