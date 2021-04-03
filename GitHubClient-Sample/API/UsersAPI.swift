//
//  UsersAPI.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import Foundation

struct UsersResponse: Decodable {
    var id: Int64
    var login: String
    var avatar_url: URL
    var name: String?
    var followers: Int
    var following: Int
    var repos_url: String
}


class UsersAPI: APIRequestable {
    typealias ResponseType = UsersResponse
    
    private var query: String = ""
    
    
    var url: URL {
        let components = URLComponents(string: Constans.apiEndpoint + "users/\(query.urlEncode)")!
        
        return components.url!
    }
    
    
    func request(query: String,
                 completion: @escaping RequestCompletionHandler) {
        self.query = query
        
        request(completion: { (resp, error) in
            completion(resp as ResponseType?, error)
        })
    }
    
}
