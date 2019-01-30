//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Paul Yi on 1/29/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class SearchResultController {
    // Data source for the table view
    var searchResults: [SearchResult] = []
    // Add a baseURL constant
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    // Create a performSearch function
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else { NSLog("Unable to resolve baseURL to components.") ; completion(NSError()) ; return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // Create a data task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Check for errors
            if let error = error {
                NSLog("Could not retrieve data from JSON in the dataTask: \(error.localizedDescription)")
                completion(NSError())
            }
            // Unwrap the data
            guard let data = data else {
                NSLog("No data found.") ; completion(NSError()) ; return
            }
            // Decode SearchResults from the data returned from the data task
            do {
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                // call completion with nil
                completion(nil)
            }
            catch {
                NSLog("Unable to decode JSON data.")
                // call completion with error
                completion(NSError())
            }
            // Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task
        }.resume()
    }
}
