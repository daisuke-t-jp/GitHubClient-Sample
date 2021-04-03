//
//  UserTableViewCell.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    // MARK: - Constans
    static let reuseIdentifier = "UserTableViewCellIdentifier"
    static let height: CGFloat = 70

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
        self.avatarImageView.clipsToBounds = true
    }
    
    
    func setDummy() {
        avatarImageView.image = UIImage(named: "octobat")
        nameLabel.text = "No users."
    }
    
    
    func setItem(item: SearchUsersItem) {
        nameLabel.text = item.login
        
        var urlComponents = URLComponents(string: item.avatar_url.absoluteString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "size", value: "\(avatarImageView.frame.width)")
        ]
        
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: urlComponents.url,
                                    placeholder: nil,
                                    options: [
                                        .transition(.fade(0.5))
                                    ],
                                    completionHandler: { result in
                                        self.setNeedsLayout()
                                    })
    }
    
}
