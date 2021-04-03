//
//  UserListViewController.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import UIKit

import Toast_Swift

class UserListViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - Property
    private var latestSearchText = ""
    private var reservedSearchText: String?
    private var isSearching: Bool = false
    var items: [SearchUsersItem] = []
    private let searchUserAPIClient = SearchUsersAPI()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil),
                           forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)

        searchBar.placeholder = "username"
        searchBar.delegate = self
        searchBar.keyboardType = .alphabet
        searchBar.autocapitalizationType = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}


// MARK: - UISearchBarDelegate
extension UserListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else {
            return
        }
        
        search(searchText: "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let text = searchBar.text?.components(separatedBy: CharacterSet.whitespaces).joined()
        search(searchText: text ?? "")
    }
    
}


// MARK: - Search
private extension UserListViewController {
    
    func search(searchText: String) {
        guard latestSearchText != searchText else {
            return
        }
        
        guard !isSearching else {
            reservedSearchText = searchText
            return
        }
        
        
        isSearching = true
        latestSearchText = searchText
        searchUsers(searchText: searchText)
    }
    
    func searchUsers(searchText: String) {
        guard !searchText.isEmpty else {
            self.items = []
            self.searchComplete(searchText: searchText)
            return
        }
        
        
        searchUserAPIClient.request(query: searchText) { (resp, error) in
            defer {
                self.searchComplete(searchText: searchText)
            }
            
            if let error = error {
                switch error {
                case let .decode(string):
                    self.view.makeToast(string)
                default:
                    self.view.makeToast("server error")
                }
                return
            }
            
            guard let resp = resp else {
                self.items = []
                return
            }
            
            
            self.items = resp.items
        }
    }
    
    
    func searchComplete(searchText: String) {        
        tableView.allowsSelection = items.count > 0
        tableView?.reloadData()
        
        isSearching = false
        
        guard let searchTextNext = reservedSearchText else {
            return
        }

        reservedSearchText = nil
        search(searchText: searchTextNext)
    }
    
}
