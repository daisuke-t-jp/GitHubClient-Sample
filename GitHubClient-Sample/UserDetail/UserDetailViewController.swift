//
//  UserDetailViewController.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import UIKit

import ImageViewer_swift

class UserDetailViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    
    // MARK: - Property
    var login: String = ""
    var items: [RepoItem] = []
    private var headerView: UserView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: RepoTableViewCell.reuseIdentifier)
        
        
        headerView = UserView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 300))
        tableView.tableHeaderView = headerView
        
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .large
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = login
        
        
        activityIndicatorView.startAnimating()
        
        load(login: login)
    }
    
}


// MARK: - Load
private extension UserDetailViewController {
    
    func load(login: String) {
        loadUser(login: login)
    }
    
    
    func loadUser(login: String) {
        
        UsersAPI().request(query: login) { (resp, error) in
            self.updateHeader(usersResponse: resp)
            
            self.loadRepo(login: login)
       }
        
    }
    
    
    func loadRepo(login: String) {
        ReposAPI().request(query: login) { (resp, error) in
            defer {
                self.loadComplete()
            }
            
            
            guard error == nil,
                  let resp = resp else {
                self.items = []
                return
            }
            
            self.items = resp.filter { $0.fork == false }
        }
    }
    
    
    func loadComplete() {
        activityIndicatorView.stopAnimating()
        
        tableView?.allowsSelection = items.count > 0
        tableView?.reloadData()
    }
    
}


// MARK: - Header
private extension UserDetailViewController {
    
    func updateHeader(usersResponse: UsersResponse?) {
        guard let usersResponse = usersResponse,
              let headerView = headerView else {
            return
        }
        
        
        headerView.avatarImageView.layer.cornerRadius = headerView.avatarImageView.frame.width / 2
        headerView.avatarImageView.clipsToBounds = true
        headerView.avatarImageView.kf.indicatorType = .activity
        headerView.avatarImageView.kf.setImage(with: usersResponse.avatar_url,
                                         placeholder: nil,
                                         options: [
                                            .transition(.fade(0.5))
                                         ],
                                         completionHandler: { result in
                                            headerView.avatarImageView.setupImageViewer(options: [.theme(.dark)],
                                                                                        from: nil)
                                         })

        
        headerView.loginLabel.text = usersResponse.login
        headerView.nameLabel.text = usersResponse.name ?? ""
        headerView.followLabel.text = "\(usersResponse.followers) followers · \(usersResponse.following) following"

    }
    
}
