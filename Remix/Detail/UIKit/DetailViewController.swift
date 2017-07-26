//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class DetailViewControllerFactory: DetailViewFactory {
    func make() -> DetailView {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DetailViewController else { preconditionFailure() }
        return viewController
    }
}

class DetailViewController: UIViewController, DetailView {

    @IBOutlet weak var titleLabel: UILabel!

    var viewData: DetailViewData? {
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
