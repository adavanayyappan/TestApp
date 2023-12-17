//
//  SearchRepositoryViewController.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 16/12/23.
//

import UIKit

class SearchViewController: UIViewController {
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search repositiry..."
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.autocapitalizationType = .allCharacters
        definesPresentationContext = true
        return searchController
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        return tableView
    }()
    private let headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        headerView.backgroundColor = .white
        return headerView
    }()
    private let labelHeaderSection: UILabel = {
        let labelHeaderSection = UILabel()
        labelHeaderSection.textAlignment = .left
        labelHeaderSection.font = .systemFont(ofSize: 25, weight: .heavy)
        labelHeaderSection.textColor = .black
        return labelHeaderSection
    }()
    private let nothingFoundPlaceholder: UIImageView = {
        let nothingFoundPlaceholder = UIImageView()
        nothingFoundPlaceholder.image = UIImage(systemName: "plus.rectangle.on.folder")
        nothingFoundPlaceholder.contentMode = .scaleAspectFill
        return nothingFoundPlaceholder
    }()
    private let backBarButtonItem: UIBarButtonItem = {
        let backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .white
        return backBarButtonItem
    }()
    private var searchWithLimits = true
    private var isSearching = false
    private var searchQuery: String = ""
    private var displCells = 0
    private var currentSearchPage = 1
    private var currentPopularPage = 1
    private let presenter: RepositoryViewHandler
    private var repositoryItems = [Repository]()
    private var indexPath: IndexPath?
    
    init(presenter: RepositoryViewHandler) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Repository"
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.backBarButtonItem = backBarButtonItem
        searchController.hidesNavigationBarDuringPresentation = false
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        labelHeaderSection.frame = CGRect(x: 20, y: 0, width: 300, height: 50)
        nothingFoundPlaceholder.frame = CGRect(x: tableView.frame.midX, y: tableView.frame.midY, width: view.frame.size.width/4, height: view.frame.height/4)
        nothingFoundPlaceholder.center = tableView.center
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchController.searchBar.endEditing(true)
    }
}

extension SearchViewController: RepositoryViewInterface {
    func presentRepositoryViewData(viewData: RepositoryList) {
        for item in viewData.items {
            repositoryItems.append(item)
        }
        tableView.reloadData()
        if repositoryItems.isEmpty {
            tableView.tableFooterView = nil
            view.addSubview(nothingFoundPlaceholder)
        } else {
            displCells = tableView.visibleCells.count
            if let indexPath = indexPath, tableView.indexPathExists(indexPath: IndexPath(row: indexPath.row, section: indexPath.section)) {
                tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            }
            self.tableView.tableFooterView = nil
        }
    }
    
    func presentProgressStart() {
        tableView.tableFooterView = spinerFooter()
    }
    
    func presentProgressFinish() {
        tableView.tableFooterView = nil
    }
    
    func presentErrorViewData(error: Error?) {
        if let error = error {
            tableView.tableFooterView = nil
            print(error)
        }
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchQuery != "" {
            nothingFoundPlaceholder.removeFromSuperview()
            self.repositoryItems.removeAll()
            self.tableView.reloadData()
            isSearching = true
            indexPath = IndexPath(row: 0, section: 0)
            presenter.searchRepository(query: searchQuery, currentPage: currentSearchPage)
        } else {
            isSearching = false
            nothingFoundPlaceholder.removeFromSuperview()
            self.repositoryItems.removeAll()
            self.tableView.reloadData()
            indexPath = IndexPath(row: 0, section: 0)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
    }
}

// MARK: - TableView delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repositoryItems.isEmpty {
            return 0
        } else {
            return repositoryItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell() }
        if !repositoryItems.isEmpty {
            cell.namelbl.text = repositoryItems[indexPath.row].name
            if let stars = repositoryItems[indexPath.row].stargazersCount {
                cell.starlbl.text = "☆ \(stars)"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if repositoryItems.count != displCells {
            if indexPath.row == repositoryItems.count - 1 {
                currentSearchPage += 1
                self.indexPath = indexPath
                presenter.searchRepository(query: searchQuery, currentPage: currentSearchPage)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        labelHeaderSection.text = "Repositories"
        headerView.addSubview(labelHeaderSection)
        return headerView
    }
}

// MARK: - Create spiner footer(activity indicator)
extension UIViewController {
    func spinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spiner = UIActivityIndicatorView()
        spiner.center = footerView.center
        spiner.startAnimating()
        footerView.addSubview(spiner)
        return footerView
    }
}

// MARK: - Check if indexPath exist
extension UITableView {
    func indexPathExists(indexPath:IndexPath) -> Bool {
        if indexPath.section >= self.numberOfSections {
            return false
        }
        if indexPath.row >= self.numberOfRows(inSection: indexPath.section) {
            return false
        }
        return true
    }
}
