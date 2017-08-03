//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

protocol PrimeViewControllerDelegate: class {
    func didTapOK()
}

struct PrimeViewData {
    let result: String
}

class PrimeViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel?

    weak var delegate: PrimeViewControllerDelegate?
    var viewData: PrimeViewData? {
        didSet {
            updateView()
        }
    }

    @IBAction func didTapOK(_ sender: Any) {
        delegate?.didTapOK()
    }

    private func updateView() {
        resultLabel?.text = viewData?.result
    }
}
