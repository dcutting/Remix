//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class SelectionListViewControllerWireframe: SelectionListViewWireframe {
    func make() -> SelectionListView {
        return SelectionListViewController()
    }
}

class SelectionListViewController: UITableViewController, SelectionListView {
    var delegate: SelectionListViewDelegate?
    var viewData: SelectionListViewData? {
        didSet {
            update()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }

    private func update() {
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
        delegate?.didSelectItem(at: indexPath.row)
    }
}
