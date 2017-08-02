//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Entity

class ItemDetailViewControllerFactory: ItemDetailViewFactory {
    func make() -> ItemDetailView {
        let storyboard = UIStoryboard(name: "ItemDetailViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? ItemDetailViewController else { preconditionFailure() }
        return viewController
    }
}

class ItemDetailViewController: UIViewController, ItemDetailView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    var viewData: ItemDetailViewData? {
        didSet {
            updateView()
        }
    }

    override func loadView() {
        super.loadView()
        updateView()
    }

    private func updateView() {
        guard isViewLoaded else { return }
        titleLabel.text = viewData?.title
        textView.text = viewData?.detail
    }
}
