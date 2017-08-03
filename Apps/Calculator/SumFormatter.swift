//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class SumFormatter {

    let numberFormatter = NumberFormatter()

    init() {
        numberFormatter.numberStyle = .spellOut
    }

    func prepare(result: SumInteractor.Result) -> SumViewData {

        let left = stringify(result.firstTerm)
        let right = stringify(result.secondTerm)
        let spelledOutResult = numberFormatter.string(for: result.sum) ?? ""

        return SumViewData(left: left, right: right, result: spelledOutResult)
    }

    private func stringify(_ int: Int?) -> String {
        return int.flatMap { String($0) } ?? ""
    }
}
