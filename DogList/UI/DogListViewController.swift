//  Copyright © 2020 ACartagena. All rights reserved.

import UIKit
import SnapKit

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension DogListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
