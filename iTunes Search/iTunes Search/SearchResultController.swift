//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Daniela Parra on 9/11/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class SearchResultController {
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        let searchURL = baseURL.appendingPathComponent("search")
        
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let parameters: [String: String] = ["term": searchTerm, "entity": resultType.rawValue]
        
        let searchTermQueryItems = parameters.compactMap({
            URLQueryItem(name: $0.key, value: $0.value)
        })
        
        components?.queryItems = searchTermQueryItems
        
        guard let requestURL = components?.url else {
            NSLog("requestURL is nil")
            completion(NSError())
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                
                self.searchResults = searchResults.results
                
                completion(nil)
            } catch {
                NSLog("Error decoding search results: \(error)")
                completion(error)
                return
            }
            
            
        }.resume()
    }
    
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []
}
