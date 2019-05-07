//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Lisa Sampson on 5/7/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import Foundation

// MARK: - URLs

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    
    // Properties
    
    var searchResults: [SearchResult] = []
    
    // MARK: - Search Methods
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem  = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else { NSLog("Request URL is nil.") ; completion(NSError()) ; return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Had some problem getting data from JSON in the dataTask: \(error)")
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
                NSLog("Unable to decode your JSON.")
                completion(NSError())
            }
            }.resume()
    }
}
