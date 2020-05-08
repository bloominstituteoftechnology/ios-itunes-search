//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Bronson Mullens on 5/6/20.
//  Copyright © 2020 Bronson Mullens. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    // Data source for table view
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        let searchTermQuery = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [searchTermQuery, resultTypeQuery]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: requestURL) {
            (data, _, error) in
            if let error = error {
                NSLog("Error with data task: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = search.results
                completion()
            } catch {
                NSLog("Unable to decode data")
                completion()
                return
            }
        }   .resume()
    }
    
}
