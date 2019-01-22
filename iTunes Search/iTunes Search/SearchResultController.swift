//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Nathanael Youngren on 1/22/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void ) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        urlComponents.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL: \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned.")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let results = searchResults.results
                completion(results, nil)
            } catch {
                NSLog("Unable to decode data into results: \(error)")
                completion(nil, error)
                return
            }
            
        }.resume()
        
    }
}
