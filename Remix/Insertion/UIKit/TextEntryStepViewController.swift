//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class TextEntryStepViewControllerFactory: TextEntryStepViewFactory {
    func make() -> TextEntryStepView {
        let storyboard = UIStoryboard(name: "TextEntryStepViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? TextEntryStepViewController else { preconditionFailure() }
        return viewController
    }
}

class TextEntryStepViewController: UIViewController, TextEntryStepView {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var textView: UITextView?
    
    var delegate: TextEntryStepViewDelegate?
    var viewData: TextEntryStepViewData? {
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
        titleLabel?.text = viewData?.title
        textView?.text = viewData?.value
    }

    @IBAction func didTapNext(_ sender: Any) {
        guard let text = textView?.text else { return }
        delegate?.didTapNext(withText: text)
    }

    func navigationWireframeDidGoBack() {
        delegate?.didGoBack()
    }
}
