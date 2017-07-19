//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class DetailViewControllerWireframe: DetailViewWireframe {
    func make() -> DetailView {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DetailViewController else { preconditionFailure() }
        return viewController
    }
}

class DetailViewController: UIViewController, DetailView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    var viewData: DetailViewData? {
        didSet {
            update()
        }
    }

    override func loadView() {
        super.loadView()
        update()
    }

    private func update() {
        guard isViewLoaded else { return }
        titleLabel.text = viewData?.title
        categoryLabel.text = viewData?.category
    }
}
