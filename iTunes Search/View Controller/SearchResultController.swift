//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Andrew Ruiz on 10/1/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // TODO: Should we add the question mark or remove it?
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        // Build out the URL
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItemTerm = URLQueryItem(name: "term", value: searchTerm)
        let searchQueryItemEntity = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = [searchQueryItemTerm, searchQueryItemEntity]
        
        guard let requestURL = components?.url else {
            completion(NSError())
            return
        }
        
        // Create a URLRequest
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Perform the request (with a data task)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Handle any errors
            
            if let error = error {
                NSLog("Error fetching iTunes content: \(error)")
                completion(NSError())
                return
            }
            
            // (Usually) decode the data
            guard let data = data else {
                NSLog("No data returned from iTunes search")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into iTunes Search: \(error)")
                completion(error)
            }
            completion(NSError())
        }
        // This is what performs the data task, or gets it to go to the server
        dataTask.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
