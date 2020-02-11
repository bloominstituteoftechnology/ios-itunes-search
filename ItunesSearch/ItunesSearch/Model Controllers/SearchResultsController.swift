//
//  SearchResultsController.swift
//  ItunesSearch
//
//  Created by scott harris on 2/11/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

class SearchResultsController {
    let baseURL = URL(string: "https://itunes.apple.com")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error Receiving Data from api: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Data error from api")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                NSLog("Error Parsing Data into SearchResults: \(error)")
                completion(error)
                
            }
            
        }
        
        dataTask.resume()
        
    }
    
}
