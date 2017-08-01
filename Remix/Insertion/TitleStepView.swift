//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Wireframe

protocol TitleStepViewFactory {
    func make() -> TitleStepView
}

protocol TitleStepView: Navigatable {
    weak var delegate: TitleStepViewDelegate? { get set }
    var viewData: TitleStepViewData? { get set }
}

protocol TitleStepViewDelegate: class {
    func didTapNext(withTitle: String)
    func didGoBack()
}

struct TitleStepViewData {
    let title: String
}
