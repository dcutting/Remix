//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

protocol CalculatorViewDelegate: class {
    func viewReady()
    func didChange(left: String)
    func didChange(right: String)
    func didTapAbout()
}

struct CalculatorViewData {
    let left: String
    let right: String
    let result: String
}

class CalculatorViewController: UIViewController {

    @IBOutlet weak var leftTextField: UITextField?
    @IBOutlet weak var rightTextField: UITextField?
    @IBOutlet weak var resultLabel: UILabel?

    weak var delegate: CalculatorViewDelegate?
    var viewData: CalculatorViewData? {
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

extension CalculatorViewController {

    @IBAction func leftDidChange(_ sender: Any) {
        guard let text = leftTextField?.text else { return }
        delegate?.didChange(left: text)
    }

    @IBAction func rightDidChange(_ sender: Any) {
        guard let text = rightTextField?.text else { return }
        delegate?.didChange(right: text)
    }

    @IBAction func didTapAbout(_ sender: Any) {
        delegate?.didTapAbout()
    }
}
