//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Ilgar Ilyasov on 9/18/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Properties
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    // MARK: - Fetching data
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        // Reset the values of searchResults
        searchResults = []
        
        // Create component
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        // Create query items
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryitem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // Set the querry items of the component
        urlComponent.queryItems = [searchQueryItem, entityQueryitem]
        
        // Make sure the url is a valid url
        guard let requestURL = urlComponent.url else {
            NSLog("Search url is invalid: \(urlComponent)")
            completion(NSError())
            return
        }
        
        // Create a URLRequest for loading/caching data and set its method to GET
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Create a data transfer task, retrieve contents of the URL and call the handler upon completion
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // If there is an error, log it and give it to the handler
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            // If there is no data, log it and return an error to the handler
            guard let data = data else {
                NSLog("Error. No data returned")
                completion(error)
                return
            }
            
            do {
                
                // Create an instance of JSONDecoder and convert its key decoding strategy from snake-case to camel-case
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // If data can be decoded set the search result to it and call the handler
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                
                // If not, log the error and pass it to the handler
                NSLog("Error decoding data: \(error)")
                completion(error)
            }
        }.resume() // Resume the data transfer task
    }
}
