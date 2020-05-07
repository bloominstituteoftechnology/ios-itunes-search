//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Rob Vance on 5/5/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // Mark: Properties
    
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    var searchResults: [SearchResult] = []

    // Mark enum
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // Mark: Functions
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        // Building endpoint URL with query item
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let parameters: [String : String] = ["term" : searchTerm, "entity" : resultType.rawValue]
        let queryItems = parameters.compactMap({URLQueryItem(name: $0.key, value: $0.value)})
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        // Creating URL Request
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Creating URL Task
        
        URLSession.shared.dataTask(with: request) {(data, _, error) in
            
            // handle error
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            guard let data = data else {
                completion()
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                NSLog("Error fetching data: \(error)")
                completion()
            }
            completion()
        }.resume()
        
    }
}
