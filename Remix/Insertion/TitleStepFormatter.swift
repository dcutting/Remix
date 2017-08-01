//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class TitleStepFormatter {
    func prepare(draft: Draft) -> TitleStepViewData {
        let title = draft.title ?? ""
        return TitleStepViewData(title: title)
    }
}
