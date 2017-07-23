//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class DiscoveryListViewControllerWireframe: DiscoveryListViewWireframe {
    func make() -> DiscoveryListView {
        return DiscoveryListViewController()
    }
}

class DiscoveryListViewController: UITableViewController, DiscoveryListView {

    weak var delegate: DiscoveryListViewDelegate?
    var viewData: DiscoveryListViewData? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didTapFilter))
        updateView()
    }

    @objc private func didTapFilter() {
        delegate?.doesWantFilters()
    }

    private func updateView() {
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
        guard let classifiedAdID = viewData?.items[indexPath.row].classifiedAdID else { return }
        delegate?.didSelect(classifiedAdID: classifiedAdID)
    }
}
