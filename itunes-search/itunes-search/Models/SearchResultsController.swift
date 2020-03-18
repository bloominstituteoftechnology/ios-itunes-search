//
//  SearchResultsController.swift
//  itunes-search
//
//  Created by Jarren Campos on 3/13/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)

        let parameters: [String: String] = ["term": searchTerm, "entity": resultType.rawValue]
        
        let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else {
            NSLog("request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting data: \(error)")
                return
            }
            
            guard let data = data else {
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
            } catch {
                NSLog("Error unable to decode data: \(error)")
            }
            completion()
        }.resume()
    }
}
