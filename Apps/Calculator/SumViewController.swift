//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

protocol SumViewDelegate: class {
    func viewReady()
    func didChange(left: String)
    func didChange(right: String)
    func didTapAnalyse()
}

struct SumViewData {
    let left: String
    let right: String
    let result: String
}

class SumViewController: UIViewController {

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
        delegate?.viewReady()
    }

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
