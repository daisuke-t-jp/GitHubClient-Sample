//
//  UserView.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/30.
//

import UIKit
import SafariServices

class UserView: UIView {
    
    // MARK: - Outlet
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    
    var htmlURL: String?
    weak var viewController: UIViewController?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        loadNib()
    }
    
    private func loadNib() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)),
                                                                  owner: self,
                                                                  options: nil)?.first as? UIView else {
            return
        }
        
        view.frame = self.bounds
        self.addSubview(view)
        
        
        loginLabel.text = ""
        nameLabel.text = ""
        followLabel.text = ""
    }
    
    
    @IBAction func actionProfileButton(_ sender: Any) {
        guard let viewController = viewController,
              let htmlURL = htmlURL,
              let url = URL(string: htmlURL) else {
            return
        }
        
        
        let viewController2 = SFSafariViewController(url: url)
        viewController.present(viewController2, animated: true, completion: nil)
    }
    
}
