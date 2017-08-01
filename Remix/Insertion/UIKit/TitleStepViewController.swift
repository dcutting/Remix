//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class TitleStepViewControllerFactory: TitleStepViewFactory {
    func make() -> TitleStepView {
        let storyboard = UIStoryboard(name: "TitleStepViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? TitleStepViewController else { preconditionFailure() }
        return viewController
    }
}

class TitleStepViewController: UIViewController, TitleStepView {

    @IBOutlet weak var titleTextField: UITextField?

    var delegate: TitleStepViewDelegate?
    var viewData: TitleStepViewData? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    private func updateView() {
        guard isViewLoaded else { return }
        titleTextField?.text = viewData?.title
    }

    @IBAction func didTapNext(_ sender: Any) {
        guard let text = titleTextField?.text else { return }
        delegate?.didTapNext(withTitle: text)
    }

    func navigationWireframeDidGoBack() {
        delegate?.didGoBack()
    }
}
