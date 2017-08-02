//  Copyright © 2017 cutting.io. All rights reserved.

import Entity

class TitleStepFormatter {
    func prepare(draft: Draft) -> TextEntryStepViewData {
        let title = "Advert title"
        let value = draft.title ?? ""
        return TextEntryStepViewData(title: title, value: value)
    }
}
