//
//  String.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import Foundation

extension String {
    
    var urlEncode: String {
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        let str = removingPercentEncoding ?? self
        
        return str.addingPercentEncoding(withAllowedCharacters: charset) ?? str
    }
    
}
