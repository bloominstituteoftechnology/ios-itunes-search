//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Julian A. Fordyce on 1/22/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string:"https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func perfomSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        let resultQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchQueryItem, resultQueryItem]
        
        guard let requestURL =  urlComponents?.url else {
            NSLog("Error constructinh search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was an error getting data: \(error)")
                completion(NSError())
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(NSError())
            } catch {
                NSLog("Unable to decode JSON")
                completion(NSError())
            }
        }.resume()
    }
    
}

