//  Copyright © 2017 cutting.io. All rights reserved.

class FakeAdvertDetailViewFactory: AdvertDetailViewFactory {

    let fake: AdvertDetailView

    init(fake: AdvertDetailView) {
        self.fake = fake
    }

    func make() -> AdvertDetailView {
        return fake
    }
}
