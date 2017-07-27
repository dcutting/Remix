//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation
import Entity
import Wireframe

protocol GroupSelectionViewFactory {
    func make() -> GroupSelectionView
}

protocol GroupSelectionView: Navigatable {
    weak var delegate: GroupSelectionViewDelegate? { get set }
    var viewData: GroupSelectionViewData? { get set }
}

protocol GroupSelectionViewDelegate: class {
    func didSelect(groupID: GroupID)
    func didDeselectAll()
    func didAbortSelection(fromView: GroupSelectionView)
}

struct GroupSelectionViewData {
    let title: String
    let items: [GroupSelectionViewDataItem]
}

struct GroupSelectionViewDataItem {
    let groupID: GroupID
    let title: String
    let hasChildren: Bool
}
