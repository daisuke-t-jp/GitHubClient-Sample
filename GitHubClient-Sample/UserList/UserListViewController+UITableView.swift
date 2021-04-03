//
//  UserListViewController+UITableView.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import UIKit

import Kingfisher

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard items.count > 0 else {
            return 1    // dummy
        }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        
        guard items.count > 0 else {
            cell.setDummy()
            
            return cell
        }
        
        
        let item = items[indexPath.row]
        cell.setItem(item: item)
        
        return cell
    }
    
}


extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserTableViewCell.height
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        let storyboard = UIStoryboard.init(name: "UserDetail", bundle: nil)
        guard let viewController: UserDetailViewController =
                storyboard.instantiateViewController(withIdentifier: "StoryboardIDUserDetail") as? UserDetailViewController else {
            return
        }
        viewController.login = items[indexPath.row].login
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
