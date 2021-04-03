//
//  ReposAPI.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import Foundation

struct RepoItem: Hashable, Identifiable, Decodable {
    var id: Int64
    var name: String
    var html_url: String
    var description: String?
    var fork: Bool
    var stargazers_count: Int
    var language: String?
    var forks: Int
}


class ReposAPI: APIRequestable {
    typealias ResponseType = [RepoItem]
    
    private var query: String = ""
    
    
    var url: URL {
        var components = URLComponents(string: Constans.apiEndpoint + "users/\(query.urlEncode)/repos")!
        components.queryItems = [
            URLQueryItem(name: "sort", value: "updated")
        ]
        
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
