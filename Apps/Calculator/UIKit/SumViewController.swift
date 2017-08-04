//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SumViewControllerFactory: SumViewFactory {

    func make() -> SumView {
        let storyboard = UIStoryboard(name: "SumViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? SumViewController else { preconditionFailure() }
        return viewController
    }
}

class SumViewController: UIViewController, SumView {

    @IBOutlet weak var leftTextField: UITextField?
    @IBOutlet weak var rightTextField: UITextField?
    @IBOutlet weak var resultLabel: UILabel?

    weak var delegate: SumViewDelegate?
    var viewData: SumViewData? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        delegate?.viewReady()
    }
}

extension SumViewController {

    private func updateView() {
        guard isViewLoaded else { return }
        leftTextField?.text = viewData?.left
        rightTextField?.text = viewData?.right
        resultLabel?.text = viewData?.result
    }
}

extension SumViewController {

    @IBAction func leftDidChange(_ sender: Any) {
        guard let text = leftTextField?.text else { return }
        delegate?.didChange(left: text)
    }

    @IBAction func rightDidChange(_ sender: Any) {
        guard let text = rightTextField?.text else { return }
        delegate?.didChange(right: text)
    }

    @IBAction func didTapAnalyse(_ sender: Any) {
        delegate?.didTapAnalyse()
    }
}
