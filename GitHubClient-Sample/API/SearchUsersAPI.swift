//
//  SearchUsersAPI.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/29.
//

import Foundation

struct SearchUsersResponse: Decodable {
    var items: [SearchUsersItem]
}

struct SearchUsersItem: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
    var avatar_url: URL
}


// Rate limit
//
// > The Search API has a custom rate limit. For requests using Basic Authentication,
// > OAuth, or client ID and secret, you can make up to 30 requests per minute.
// > For unauthenticated requests, the rate limit allows you to make up to 10 requests per minute.
// https://docs.github.com/ja/rest/reference/search#rate-limit

class SearchUsersAPI: APIRequestable {
    typealias ResponseType = SearchUsersResponse
    
    private var query: String = ""
    
    
    var url: URL {
        var components = URLComponents(string: Constans.apiEndpoint + "search/users")!
        components.queryItems = [
            URLQueryItem(name: "q", value: query.urlEncode)
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
