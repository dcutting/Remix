//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class AdvertListViewControllerFactory: AdvertListViewFactory {
    func make() -> AdvertListView {
        return AdvertListViewController()
    }
}

class AdvertListViewController: UITableViewController, AdvertListView {

    weak var delegate: AdvertListViewDelegate?
    var viewData: AdvertListViewData? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(didTapFilter))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapNew))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        updateView()
    }

    @objc private func didTapNew() {
        delegate?.didSelectNewAdvertAction()
    }

    @objc private func didTapFilter() {
        delegate?.didSelectFiltersAction()
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18.0)
        cell.detailTextLabel?.text = item.group
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let advertID = viewData?.items[indexPath.row].advertID else { return }
        delegate?.didSelect(advertID: advertID)
    }
}
