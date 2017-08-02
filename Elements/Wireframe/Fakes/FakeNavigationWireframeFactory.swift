//  Copyright © 2017 cutting.io. All rights reserved.

public class FakeNavigationWireframeFactory: NavigationWireframeFactory {

    let fake: NavigationWireframe

    public init(fake: NavigationWireframe) {
        self.fake = fake
    }

    public func make() -> NavigationWireframe {
        return fake
    }
}
