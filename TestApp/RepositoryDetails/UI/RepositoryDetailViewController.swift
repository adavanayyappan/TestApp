//
//  RepositoryDetailViewController.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    
    
    private let repoTableView: UITableView = {
        let repoTableView = UITableView(frame: .zero, style: .grouped)
        repoTableView.register(RepositoryDetailViewCell.self, forCellReuseIdentifier: RepositoryDetailViewCell.identifier)
        repoTableView.translatesAutoresizingMaskIntoConstraints = false
        repoTableView.rowHeight = UITableView.automaticDimension
        repoTableView.estimatedRowHeight = 100
        repoTableView.backgroundColor = .white
        repoTableView.separatorStyle = .singleLine
        return repoTableView
    }()
    
    private let repoLabel: UILabel = {
        let repoLabel = UILabel()
        repoLabel.text = "Repo title"
        repoLabel.numberOfLines = 0
        repoLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        repoLabel.translatesAutoresizingMaskIntoConstraints = false
        return repoLabel
    }()
    private let repoOwnerName: UILabel = {
        let repoOwnerName = UILabel()
        repoOwnerName.text = "Repo author name"
        repoOwnerName.font = .systemFont(ofSize: 30, weight: .heavy)
        repoOwnerName.translatesAutoresizingMaskIntoConstraints = false
        return repoOwnerName
    }()
    private let stars: UILabel = {
        let stars = UILabel()
        stars.text = "Number of stars"
        stars.font = .systemFont(ofSize: 15, weight: .light)
        stars.translatesAutoresizingMaskIntoConstraints = false
        return stars
    }()

    private let presenter: RepositoryDetailsViewHandler
    private var repositoryContributorItems = [RepositoryContributor]()
    
    init(presenter: RepositoryDetailsViewHandler) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(repoOwnerName)
        view.addSubview(stars)
        view.addSubview(repoLabel)
        view.addSubview(repoTableView)
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
        presenter.getRepositoryContributor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        repoTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            repoOwnerName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repoOwnerName.heightAnchor.constraint(equalToConstant: 40),
            repoOwnerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            repoOwnerName.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            
            stars.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stars.heightAnchor.constraint(equalToConstant: 25),
            stars.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stars.topAnchor.constraint(equalTo: repoOwnerName.bottomAnchor, constant: 20),

            repoLabel.topAnchor.constraint(equalTo: stars.bottomAnchor, constant: 20),
            repoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            repoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repoTableView.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 20),
            repoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
        ])
    }
}

extension RepositoryDetailViewController: RepositoryDetailsViewInterface {
    func presentRepositoryViewData(repositoryData: Repository) {
        if let numberOfStars = repositoryData.stargazersCount {
            stars.text = "★ Number of Stars (\(numberOfStars))"
        }
        repoOwnerName.text = "Name: \(repositoryData.name ?? "")"
        repoLabel.text = "Language: \(repositoryData.language ?? "")"
    }
    
    func presentRepositoryContributorsViewData(contributorData : [RepositoryContributor]) {
        repositoryContributorItems = contributorData
        repoTableView.reloadData()
        repoTableView.tableFooterView = nil
    }
    
    func presentProgressStart() {
        repoTableView.tableFooterView = spinerFooter()
    }
    
    func presentProgressFinish() {
        repoTableView.tableFooterView = nil
    }
    
    func presentErrorViewData(error: Error?) {
        if let error = error {
            repoTableView.tableFooterView = nil
            print(error)
        }
    }
}

// MARK: - TableView delegate
extension RepositoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryContributorItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryDetailViewCell.identifier, for: indexPath) as? RepositoryDetailViewCell else { return UITableViewCell() }
        if !repositoryContributorItems.isEmpty {
            cell.contributeName.text = repositoryContributorItems[indexPath.row].login
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Top Contributors"
        headerLabel.font = .systemFont(ofSize: 23, weight: .heavy)
        headerView.contentView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.contentView.leadingAnchor, constant: 0),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 30),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -12)
        ])
        return headerView
    }
}
