//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

protocol CalculatorViewDelegate: class {
    func viewReady()
    func didChange(first: String)
    func didChange(second: String)
    func didTapAbout()
}

struct CalculatorViewData {
    let first: String
    let second: String
    let result: String
}

class CalculatorViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField?
    @IBOutlet weak var secondTextField: UITextField?
    @IBOutlet weak var resultLabel: UILabel?

    weak var delegate: CalculatorViewDelegate?
    var viewData: CalculatorViewData? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        delegate?.viewReady()
    }

    private func configureObservers() {
        firstTextField?.addTarget(self, action: #selector(firstDidChange), for: .editingChanged)
        secondTextField?.addTarget(self, action: #selector(secondDidChange), for: .editingChanged)
    }

    private func updateView() {
        guard isViewLoaded else { return }
        firstTextField?.text = viewData?.first
        secondTextField?.text = viewData?.second
        resultLabel?.text = viewData?.result
    }
}

extension CalculatorViewController {

    @objc func firstDidChange() {
        guard let text = firstTextField?.text else { return }
        delegate?.didChange(first: text)
    }

    @objc func secondDidChange() {
        guard let text = secondTextField?.text else { return }
        delegate?.didChange(second: text)
    }

    @IBAction func didTapAbout(_ sender: Any) {
        delegate?.didTapAbout()
    }
}
