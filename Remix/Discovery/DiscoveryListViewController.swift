//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class DiscoveryListViewControllerWireframe: DiscoveryListViewWireframe {
    var view: DiscoveryListView {
        return DiscoveryListViewController()
    }
}

class DiscoveryListViewController: UITableViewController, DiscoveryListView {

    var delegate: DiscoveryListViewDelegate?
    var viewData: DiscoveryListViewData? {
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
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewData?.items[indexPath.row] else { preconditionFailure() }
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.category
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}
