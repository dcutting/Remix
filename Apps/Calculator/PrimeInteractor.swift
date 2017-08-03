//  Copyright © 2017 cutting.io. All rights reserved.

class PrimeInteractor {

    struct Result {
        let n: Int
        let isPrime: Bool
    }

    func isPrime(n: Int) -> Result {
        return Result(n: n, isPrime: isPrime(n: n))
    }

    private func isPrime(n: Int) -> Bool {
        guard n > 1 else { return false }
        guard n > 3 else { return true }
        guard n % 2 != 0, n % 3 != 0 else { return false }
        var i = 5
        while i * i <= n {
            guard n % i != 0, n % (i + 2) != 0 else { return false }
            i += 6
        }
        return true
    }
}
