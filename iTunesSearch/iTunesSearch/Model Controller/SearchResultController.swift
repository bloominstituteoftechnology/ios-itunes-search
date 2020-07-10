//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Norlan Tibanear on 7/9/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        // Declaring multiples Search Parameters
        let searchParameters = ["term" : searchTerm, "entity" : resultType.rawValue]
        let queryItems = searchParameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents?.queryItems = queryItems
        
        
        guard let requestURL = urlComponents?.url else {
            print("Request url is nil")
            completion()
            return
        }
        
        // Creating URL Request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Create URL Task
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error fetching data \(error)")
                completion()
                return
            }
            
            // Handle data optional
            guard let data = data else {
                print("No data returned")
                completion()
                return
            }
            
            // Decode Data
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                print("Unable to decode data")
            }
            completion()
        }
        task.resume()
    }//
    
    
} // Class
