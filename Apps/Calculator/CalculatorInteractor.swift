//  Copyright © 2017 cutting.io. All rights reserved.

class CalculatorInteractor {

    struct Result {
        let first: Int?
        let second: Int?
        let sum: Int?
    }

    private let service: CalculatorService

    private var first: Int?
    private var second: Int?

    var result: Result {
        var sum: Int?
        if let first = first, let second = second {
            sum = first + second
        }
        return Result(first: first, second: second, sum: sum)
    }

    init(service: CalculatorService) {
        self.service = service
    }

    func update(first: String) -> Result {
        self.first = Int(first)
        return result
    }

    func update(second: String) -> Result {
        self.second = Int(second)
        return result
    }
}
