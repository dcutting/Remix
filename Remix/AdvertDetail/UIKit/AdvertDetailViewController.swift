//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit
import Entity

class AdvertDetailViewControllerFactory: AdvertDetailViewFactory {
    func make() -> AdvertDetailView {
        let storyboard = UIStoryboard(name: "AdvertDetailViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? AdvertDetailViewController else { preconditionFailure() }
        return viewController
    }
}

class AdvertDetailViewController: UIViewController, AdvertDetailView {

    @IBOutlet weak var titleLabel: UILabel!

    var viewData: AdvertDetailViewData? {
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
    }
}
