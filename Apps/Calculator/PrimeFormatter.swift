//  Copyright © 2017 cutting.io. All rights reserved.

class PrimeFormatter {

    func prepare(result: PrimeInteractor.Result) -> PrimeViewData {
        let notText = result.isPrime ? "" : "not "
        let emoji = result.isPrime ? "🤓" : "😔"
        let output = "\(result.n) is \(notText)prime\n\(emoji)"
        return PrimeViewData(result: output)
    }
}
