//
//  ViewController.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

import UIKit

class UsersListViewController: UIViewController {
    
    private let viewModel = UsersListViewModel()
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
        viewModel.onUsersChanged = {
            self.tableView.reloadData()
        }
        viewModel.fetchUsers()
    }

    private func setupNavBar() {
        title = "iOS Concurrency"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserViewCell.self, forCellReuseIdentifier: "UserViewCell")
        
        [tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getUsersCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserViewCell", for: indexPath) as! UserViewCell
        let user = viewModel.getUserForIndex(indexPath.row)
        if let user = user {
            cell.configure(with: user)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.getUserForIndex(indexPath.row)
        if let userId = user?.id {
            let postVC = PostsListViewController(userId: userId)
            navigationController?.pushViewController(postVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Users"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.frame = CGRect(x: 15, y: 0, width: tableView.frame.width, height: 44)
        
        let view = UIView()
        view.addSubview(label)
        view.backgroundColor = .systemBackground
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

