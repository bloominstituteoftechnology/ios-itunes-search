//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Marissa Gonzales on 5/4/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var searchResults: [SearchResult] = []
    
    private let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        // URL Components
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        // Search Parameters
        let parameters : [String : String] = ["term" : searchTerm, "entity" : resultType.rawValue]
        // Query Items
        let queryItems = parameters.compactMap({URLQueryItem(name: $0.key, value: $0.value)})
        
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //Creating data task
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                
                NSLog("Error with data task: \(error)")
            }
            
            guard let data = data else {
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
                
            }  catch {
                NSLog("Error with data task: \(error)")
            }
            completion()
            
        }.resume()
    }
}
