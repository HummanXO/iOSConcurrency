//
//  PostsListViewController.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

import UIKit

class PostsListViewController: UIViewController {
    
    private let viewModel = PostsListViewModel()
    private let tableView = UITableView()
    private let userId: Int
    
    init (userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
        viewModel.onPostsUpdated = {
            self.tableView.reloadData()
        }
        viewModel.fetchPosts(of: userId)
    }
    
    private func setupNavBar() {
        title = "iOS Cuncurrency"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostsViewCell.self, forCellReuseIdentifier: "PostsViewCell")
        
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

extension PostsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getPostsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsViewCell", for: indexPath) as! PostsViewCell
        let post = viewModel.getPost(at: indexPath.row)
        if let post = post {
            cell.configure(with: post)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Posts"
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
