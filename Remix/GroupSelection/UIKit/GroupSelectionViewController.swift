//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class GroupSelectionViewControllerFactory: GroupSelectionViewFactory {
    func make() -> GroupSelectionView {
        return GroupSelectionViewController()
    }
}

class GroupSelectionViewController: UITableViewController, GroupSelectionView {

    weak var delegate: GroupSelectionViewDelegate?
    var viewData: GroupSelectionViewData? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        updateView()
    }

    @objc private func reset() {
        delegate?.didDeselectAll()
    }

    func navigationWireframeDidGoBack() {
        delegate?.didAbortSelection(fromView: self)
    }

    private func updateView() {
        guard isViewLoaded else { return }
        title = viewData?.title
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewData?.items[indexPath.row] else { preconditionFailure() }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = item.title
        cell.accessoryType = item.hasChildren ? .disclosureIndicator : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupID = viewData?.items[indexPath.row].groupID else { return }
        delegate?.didSelect(groupID: groupID)
    }
}
