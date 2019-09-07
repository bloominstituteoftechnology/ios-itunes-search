//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Joel Groomer on 9/7/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")
    var searchResults: [SearchResult] = []
    
    func clearResults() {
        searchResults = []
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        guard let baseURL = baseURL else {
            completion(nil)
            return
        }
        var searchURLComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryItems = [URLQueryItem(name: "entity", value: resultType.rawValue),
                          URLQueryItem(name: "term", value: searchTerm)]
        
        searchURLComponents?.queryItems = queryItems
        
        guard let requestURL = searchURLComponents?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                completion(err)
                return
            }
            guard let data = data else {
                print("no data")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let itemSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = itemSearch.results
            } catch {
                print("Unable to decode JSON: \(error)")
                return
            }
            completion(nil)
        }.resume()
    }
}
