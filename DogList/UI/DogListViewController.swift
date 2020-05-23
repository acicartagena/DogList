//  Copyright © 2020 ACartagena. All rights reserved.

import SnapKit
import UIKit

class DogListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180.0
        tableView.tableFooterView = UIView()
        tableView.dataSource = self

        tableView.register(DogListCell.self)
        return tableView
    }()

    private let viewModel: DogListViewModel

    init() {
        viewModel = DogListViewModel()
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setupUI()
        viewModel.start()
    }

    private func setupUI() {
        navigationItem.title = viewModel.title

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.sortActionTitle, style: .plain, target: self, action: #selector(sort))
    }

    @objc
    func sort() {
        let alert = UIAlertController(title: viewModel.sortActionDescription, message: nil, preferredStyle: .actionSheet)
        for sortBy in DogListViewModel.SortBy.allCases {
            let action = UIAlertAction(title: sortBy.title, style: .default) { [weak self] _ in
                self?.viewModel.sort(by: sortBy)
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension DogListViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell: DogListCell = tableView.dequeCell(for: indexPath)
        cell.configure(with: item)
        return cell
    }
}

extension DogListViewController: DogListViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
