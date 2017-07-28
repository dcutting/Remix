//  Copyright © 2017 cutting.io. All rights reserved.

class FakeAdvertListViewFactory: AdvertListViewFactory {
    
    let fake: AdvertListView
    
    init(fake: AdvertListView) {
        self.fake = fake
    }
    
    func make() -> AdvertListView {
        return fake
    }
}
