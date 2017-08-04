//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe

protocol SumViewFactory {
    func make() -> SumView
}

protocol SumView: Viewable {
    weak var delegate: SumViewDelegate? { get set }
    var viewData: SumViewData? { get set }
}

protocol SumViewDelegate: class {
    func viewReady()
    func didChange(left: String)
    func didChange(right: String)
    func didTapAnalyse()
}

struct SumViewData {
    let left: String
    let right: String
    let result: String
}
