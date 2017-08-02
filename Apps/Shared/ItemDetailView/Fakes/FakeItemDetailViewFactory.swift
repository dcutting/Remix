//  Copyright © 2017 cutting.io. All rights reserved.

class FakeItemDetailViewFactory: ItemDetailViewFactory {

    let fake: ItemDetailView

    init(fake: ItemDetailView) {
        self.fake = fake
    }

    func make() -> ItemDetailView {
        return fake
    }
}
