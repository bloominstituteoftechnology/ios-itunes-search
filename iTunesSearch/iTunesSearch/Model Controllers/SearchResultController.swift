//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Jonalynn Masters on 10/1/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import Foundation

class SearchResultController{
    
    let baseURL = URL(string: "https://itunes.apple.com/search")! // base url for itunes api
    
    var searchResults: [SearchResult] = [] // data source for the tableView
    
    // MARK: Functions
    
    // function with searchTerm: String, resultType: ResultType, and completion should take an Error? argument and return a void
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
      let parameters: [String: String] = ["term": searchTerm,
                          "entity": resultType.rawValue]
        
        let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        
        urlComponents?.queryItems = queryItems
        
        guard let fullRequestURL = urlComponents?.url else {
            NSLog("request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: fullRequestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching results: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from search")
                completion()
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion()
            } catch {
                completion()
                NSLog("Unable to decode data into SearchResults: \(error)")
            }
        }
            dataTask.resume()        
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
