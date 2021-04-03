//
//  RepoTableViewCell.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!

    
    // MARK: - Constans
    static let reuseIdentifier = "RepoTableViewCellIdentifier"
    static let height: CGFloat = 100

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setItem(item: RepoItem) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description ?? "No description."
        starLabel.text = "⭐️\(item.stargazers_count.shortString)"
        forkLabel.text = "🍴\(item.forks.shortString)"
        languageLabel.text = item.language ?? ""
    }
    
}
