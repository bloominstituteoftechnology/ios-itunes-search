//
//  SearchResultController.swift
//  iTune Search
//
//  Created by Ivan Caldwell on 12/5/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
class SearchResultController {
    //let baseURL = URL(string: "https://itunes.apple.com/search?")!
    static let endpoint = "https://itunes.apple.com/search?"
    var searchResults: [SearchResult] = []
    
    static func performSearch (with searchTerm: String , resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
    
        // Establish the base url for our search
        guard let baseURL = URL(string: endpoint)
            else { fatalError("Unable to construct baseURL") }
    
        // Decompose it into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
    
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
    
        urlComponents.queryItems = [searchQueryItem]
    
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        // Create a GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            // This closure is sent three parameters:
            data, _, error in
            
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            do {
                // Declare, customize, use the decoder
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // Perform decoding into [SearchResult] stored in SearchResult
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let inquiry = searchResults.results
                
                // Send back the results to the completion handler
                completion(inquiry, nil)
                
            } catch {
                NSLog("Unable to decode data \(error)")
                completion(nil, error)
            }
        }

        dataTask.resume()
    }
}
