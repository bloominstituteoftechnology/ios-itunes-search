//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class SearchResultController {
    // Holds the base URL for the iTunes API
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    // Holds all of our model objects
    private(set) var searchResults: [SearchResult] = []
    
    /// Performs a search call to the iTunes API with the given term and result type.
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        // Reset the results
        searchResults = []
        
        // Make compnents
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // Make query objects
        let searchTermQuery = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // Set the query objects
        components?.queryItems = [searchTermQuery, resultTypeQuery]
        
        // Make sure we can make a valid url
        guard let requestURL = components?.url else {
            NSLog("Couldn't make a request URL.")
            completion(NSError())
            return
        }
        
        // Start the data task
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            // If there is an error, log it and give it to the completion handler
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            // If there is no data, log it and return an error to the completion handler
            guard let data = data else {
                NSLog("Error. No data.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                // If the data can be decoded, set the search results to it and call the completion handler
                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = results.results
                completion(nil)
                
            } catch {
                // If not, log the error and pass it to the completion handler
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            
            
        }.resume() // **ALWAYS** make sure to resume. Otherwise you get bugs that are hard to track down and you're very confused for long time.
    }
}
