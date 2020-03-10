//
//  SearchResultController.swift
//  iTunesApp
//
//  Created by Lydia Zhang on 3/10/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import Foundation
class SearchResultController {
    //base URL for the iTunes Search API
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    //data source for the table view.
    var searchResults: [SearchResult] = []
    
    
    func search(searchTerm: String, resultType: ResultType, searchLimit: Int ,completion: @escaping (Error?) -> ()) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchTermQueryType = URLQueryItem(name: "entity", value: resultType.rawValue)
        let limit = URLQueryItem(name: "limit", value: String(searchLimit))
        urlComponents?.queryItems = [searchTermQueryItem, searchTermQueryType, limit]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Error")
            completion(nil)
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("\(error)")
            }
        
            guard let data = data else {
                NSLog("No data returned.")
                return
            }
        
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                NSLog("\(error)")
            }
            completion(error)
        }.resume()
    }
}
