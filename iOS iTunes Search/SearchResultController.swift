//
//  SearchResultController.swift
//  iOS iTunes Search
//
//  Created by Andrew Ruiz on 9/3/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        
        components?.queryItems = [searchItem]
        
        // Ask the components to give us the formatted URL from the parts we gave it.
        guard let requestURL = components?.url else {
            completion(NSError())
            return
        }
        
        print(requestURL)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // The data task hasn't gone to the API yet
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // The data task has gone to the API and come back with the data, response and error from the API.
            
            // Check for an error
            
            if let error = error {
                NSLog("Error searching for people: \(error), on line \(#line) in \(#file)")
            }
            
            // See if there is data
            
            guard let data = data else {
                NSLog("No data returned from searching for people")
                completion(NSError())
                return
            }
            
            // Decode the data
            
            do {
                let decoder = JSONDecoder()
                
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                
                self.searchResults = searchResults.results
                
                completion(nil)
            } catch {
                NSLog("Error decoding PersonSearch from data: \(error)")
                completion(error)
            }
            // completion(NSError()) // TODO: Not sure if necessary
            }.resume()

    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

}
