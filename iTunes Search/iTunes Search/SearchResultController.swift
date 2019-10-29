//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jon Bash on 2019-10-29.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(
        with searchTerm: String,
        resultType: ResultType,
        completion: @escaping (_ error: Error?) -> Void
    ) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//        let resultQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
//        let searchQuery = URLQueryItem(name: "term", value: searchTerm)
        
        let parameters: [String: String] = ["term": searchTerm, "entity": resultType.rawValue]
        
        let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        
        urlComponents?.queryItems = queryItems
        
        guard let searchURL = urlComponents?.url else {
            print("Invalid search.")
            completion(NSError())
            return
        }
        var request = URLRequest(url: searchURL)
        request.httpMethod = .getHTTP
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            guard let data = data else {
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let thisSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = thisSearch.results
                completion(nil)
            } catch {
                completion(error)
            }
        }
        task.resume()
    }
}

extension String {
    static let getHTTP = "GET"
    static let putHTTP = "PUT"
    static let postHTTP = "POST"
    static let deleteHTTP = "DELETE"
}
