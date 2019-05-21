//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Thomas Cacciatore on 5/21/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let countryQueryItem = URLQueryItem(name: "country", value: "US")
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchTermQueryItem, countryQueryItem, entityQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Unable to create URL from components")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "Get"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let returnedSearchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = returnedSearchResults.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into Object of type [SearchResult]: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    
}
