//
//  ArticlesViewController.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import UIKit

final class ArticlesViewController: UIViewController, UITableViewDataSource {
    
    private let viewModel: ArticlesViewModel
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        return tableView
    }()
    private var items: [Article] = []
    
    init(viewModel: ArticlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        viewModel.load()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
    }
    
    private func bindViewModel() {
        viewModel.onChangeState = { [weak self] state in
            self?.render(state)
        }
    }
    
    private func render(_ state: ArticlesViewModel.State) {
        switch state {
        case .idle:
            break
        case .loading:
            showLoadingView()
        case .loaded(let items):
            hideLoadingView()
            self.items = items
            tableView.reloadData()
        case .empty:
            hideLoadingView()
            showEmptyState()
        case let .failed(error):
            hideLoadingView()
            showError(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = item.title
        return cell
    }
}

// MARK: - Private methods

extension ArticlesViewController {
    private func showLoadingView() {}
    private func hideLoadingView() {}
    private func showEmptyState() {}
    private func showError(_ message: String) {}
}
