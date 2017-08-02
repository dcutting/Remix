//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe

protocol TextEntryStepViewFactory {
    func make() -> TextEntryStepView
}

protocol TextEntryStepView: Navigatable {
    weak var delegate: TextEntryStepViewDelegate? { get set }
    var viewData: TextEntryStepViewData? { get set }
}

protocol TextEntryStepViewDelegate: class {
    func didTapNext(withText text: String)
    func didGoBack(withText text: String)
}

struct TextEntryStepViewData {
    let title: String
    let value: String
}
