//  Copyright © 2017 cutting.io. All rights reserved.

import Wireframe
import Entity

public protocol GroupSelectionViewFactory {
    func make() -> GroupSelectionView
}

public protocol GroupSelectionView: Navigatable {
    weak var delegate: GroupSelectionViewDelegate? { get set }
    var viewData: GroupSelectionViewData? { get set }
}

public protocol GroupSelectionViewDelegate: class {
    func didSelect(groupID: GroupID)
    func didDeselectAll()
    func didAbortSelection(fromView: GroupSelectionView)
}

public struct GroupSelectionViewData {
    public let title: String
    public let items: [GroupSelectionViewDataItem]
}

public struct GroupSelectionViewDataItem {
    public let groupID: GroupID
    public let title: String
    public let hasChildren: Bool
}
