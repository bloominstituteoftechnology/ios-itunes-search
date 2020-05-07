//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Bronson Mullens on 5/6/20.
//  Copyright © 2020 Bronson Mullens. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    // Data source for table view
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let termQuery = URLQueryItem(name: "term", value: searchTerm)
        let typeQuery = URLQueryItem(name: "type", value: resultType.rawValue)
        urlComponents?.queryItems = [termQuery, typeQuery]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion(NSError())
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .useDefaultKeys // Direct mapping of JSON names to swift properties
            
            do {
                let search = try jsonDecoder.decode(SearchResults.self, from: data!)
                self.searchResults = search.results
                completion(NSError())
            } catch {
                NSLog("Unable to decode data: \(error)")
                return
            }
        }
        
        dataTask.resume()
    }
    
}
