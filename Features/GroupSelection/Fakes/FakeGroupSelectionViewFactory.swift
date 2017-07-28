//  Copyright © 2017 cutting.io. All rights reserved.

public class FakeGroupSelectionViewFactory: GroupSelectionViewFactory {

    let fake: GroupSelectionView

    public init(fake: GroupSelectionView) {
        self.fake = fake
    }

    public func make() -> GroupSelectionView {
        return fake
    }
}
