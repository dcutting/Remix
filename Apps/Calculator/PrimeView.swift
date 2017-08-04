//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe

protocol PrimeViewFactory {
    func make() -> PrimeView
}

protocol PrimeView: Viewable {
    weak var delegate: PrimeViewDelegate? { get set }
    var viewData: PrimeViewData? { get set }
}

protocol PrimeViewDelegate: class {
    func didTapOK()
}

struct PrimeViewData {
    let result: String
}
