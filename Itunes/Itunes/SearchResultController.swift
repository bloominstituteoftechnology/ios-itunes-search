//
//  SearchResultController.swift
//  Itunes
//
//  Created by Breena Greek on 3/13/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    private let baseURL = URL(string: "https://itunes.apple.com/search?")!
    

    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        // Create a URL components object for bast URL
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // Create a key-value pair for the end of the URL
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // Set the above Query Item to the URL Components
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        
        // Create a formal URL from the components
        guard let requestURL = urlComponents?.url else { print("Error: Request URL is nil"); completion(NSError()); return }
        
        // Required by the dataTask initializer to make a request of the API
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // This is the object that will communicate with API
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data \(error)")
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from data task.")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResult.results)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(error)
            }
        }.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
