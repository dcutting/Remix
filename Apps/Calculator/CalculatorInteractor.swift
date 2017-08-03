//  Copyright © 2017 cutting.io. All rights reserved.

class CalculatorInteractor {

    struct Result {
        let firstTerm: Int?
        let secondTerm: Int?
        let sum: Int
    }

    private var firstTerm: Int?
    private var secondTerm: Int?

    var result: Result {
        let sum = [firstTerm, secondTerm].flatMap { $0 ?? 0 }.reduce(0, +)
        return Result(firstTerm: firstTerm, secondTerm: secondTerm, sum: sum)
    }

    func update(firstTerm: String) -> Result {
        self.firstTerm = Int(firstTerm)
        return result
    }

    func update(secondTerm: String) -> Result {
        self.secondTerm = Int(secondTerm)
        return result
    }
}
