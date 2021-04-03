//
//  UserDetailViewController+UITableView.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import UIKit
import SafariServices

extension UserDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseIdentifier) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        
        
        let item = items[indexPath.row]
        cell.setItem(item: item)
        
        return cell
    }
    
}


extension UserDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepoTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        guard let url = URL(string: item.html_url) else {
            return
        }
        
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
}
