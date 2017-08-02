//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class CalculatorFormatter {

    let numberFormatter = NumberFormatter()

    init() {
        numberFormatter.numberStyle = .spellOut
    }

    func prepare(result: CalculatorInteractor.Result) -> CalculatorViewData {

        let first = stringify(result.augend)
        let second = stringify(result.addend)
        let spelledOutResult = numberFormatter.string(for: result.sum) ?? ""

        return CalculatorViewData(first: first, second: second, result: spelledOutResult)
    }

    private func stringify(_ int: Int?) -> String {
        return int.flatMap { String($0) } ?? ""
    }
}
