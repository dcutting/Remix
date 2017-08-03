//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CalculatorFormatter {

    let numberFormatter = NumberFormatter()

    init() {
        numberFormatter.numberStyle = .spellOut
    }

    func prepare(result: CalculatorInteractor.Result) -> CalculatorViewData {

        let left = stringify(result.firstTerm)
        let right = stringify(result.secondTerm)
        let spelledOutResult = numberFormatter.string(for: result.sum) ?? ""

        return CalculatorViewData(left: left, right: right, result: spelledOutResult)
    }

    private func stringify(_ int: Int?) -> String {
        return int.flatMap { String($0) } ?? ""
    }
}
