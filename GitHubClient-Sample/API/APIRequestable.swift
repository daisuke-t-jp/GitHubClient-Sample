//
//  APIRequestable.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/03/31.
//

import Foundation

import Keys

protocol APIRequestable {
    associatedtype ResponseType: Decodable
    typealias RequestCompletionHandler = (ResponseType?, APIError?) -> Void
    
    var url: URL { get }
}

enum APIError: Error {
    case unknown(Error?)
    case decode(String?)
}

struct APIErrorResponse: Decodable {
    var message: String?
}

extension APIRequestable {
    
    func request(completion: @escaping RequestCompletionHandler) {
        var request = URLRequest(url: self.url)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let token = GitHubClientKeys().gitHubPersonalAccessToken
        if !token.isEmpty {
            request.addValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
        
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default,
                                      delegate: nil,
                                      delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(nil, APIError.unknown(error))
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            
            do {
                let apiResp = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(apiResp, nil)
            } catch {
                print("# API decode error\n")
                print("## URL")
                print("- \(request.url?.absoluteString ?? "")\n")
                
                if let response = response as? HTTPURLResponse {
                    print("## Header")
                    for field in response.allHeaderFields {
                        print("- \(field.key)")
                        print("    - \(field.value)")
                    }
                    print("")
                }
                
                do {
                    let errorResp = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                    print("## Message")
                    print("- \(errorResp.message ?? "")")
                    completion(nil, APIError.decode(errorResp.message))
                } catch {
                    let dataStr = String(data: data, encoding: .utf8) ?? ""
                    print("## Response body")
                    print("- \(dataStr)")
                    completion(nil, APIError.decode(dataStr))
                }
                print("")
            }
        }
        
        task.resume()
    }
    
}
