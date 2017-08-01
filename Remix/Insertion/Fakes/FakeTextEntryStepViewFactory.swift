//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class FakeTextEntryStepViewFactory: TextEntryStepViewFactory {

    let fake: TextEntryStepView

    init(fake: TextEntryStepView) {
        self.fake = fake
    }

    func make() -> TextEntryStepView {
        return fake
    }
}
