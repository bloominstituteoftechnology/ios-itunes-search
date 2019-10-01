//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jesse Ruiz on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Properties
    let baseURL = URL(string: "https://itunes.apple.com/")!
    var searchResults: [SearchResult] = []
    
    // MARK: - Methods
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        let searchResultsURL = baseURL.appendingPathComponent("search")
        
        var components = URLComponents(url: searchResultsURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        let parameters: [String: String] = ["term": searchTerm,
                                            "entity": resultType.rawValue]
        
        let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        
        components?.queryItems = queryItems
        
        guard let requestURL = components?.url else {
            completion()
            return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from search")
                completion()
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let search = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = search.results
            } catch {
                NSLog("Unable to decode data into SearchResults: \(error)")
            }
            completion()
        }
        dataTask.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
















