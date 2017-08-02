//  Copyright © 2017 cutting.io. All rights reserved.

class CalculatorInteractor {

    struct Result {
        let augend: Int?
        let addend: Int?
        let sum: Int
    }

    private var augend: Int?
    private var addend: Int?

    var result: Result {
        let sum = [augend, addend].flatMap { $0 ?? 0 }.reduce(0, +)
        return Result(augend: augend, addend: addend, sum: sum)
    }

    func update(augend: String) -> Result {
        self.augend = Int(augend)
        return result
    }

    func update(addend: String) -> Result {
        self.addend = Int(addend)
        return result
    }
}
