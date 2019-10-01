//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Isaac Lyons on 10/1/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        // Build the URL
        
        let searchURL = baseURL.appendingPathComponent("search")
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let termQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = [termQueryItem, entityQueryItem]
        
        guard let requestURL = components?.url else {
            completion("Error constructing request URL." as? Error)
            return
        }
        
        // Perform the request
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion("No data returned from search." as? Error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                NSLog("Unable to decode data into searchResults: \(error)")
            }
            
            completion(nil)
        }
        
        dataTask.resume()
    }
}
