//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Paul Yi on 1/29/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class SearchResultController {
    var searchResults: [SearchResult] = []
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else { NSLog("Unable to resolve baseURL to components.") ; completion(NSError()) ; return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Could not retrieve data from JSON in the dataTask: \(error.localizedDescription)")
                completion(NSError())
            }
            guard let data = data else {
                NSLog("No data found.") ; completion(NSError()) ; return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(NSError())
            }
            catch {
                NSLog("Unable to decode JSON data.")
                completion(NSError())
            }
        }.resume()
    }
}
