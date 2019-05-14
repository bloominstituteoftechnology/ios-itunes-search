//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Thomas Cacciatore on 5/14/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let countryQueryItem = URLQueryItem(name: "country", value: "US")
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, countryQueryItem, entityQueryItem]
        
        guard let formattedURL = urlComponents?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: formattedURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let searchingResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchingResults.results
                
                completion(nil)
            } catch {
                NSLog("Error decoding SearchResults: \(error)")
                
                completion(error)
            }
        }
        
        dataTask.resume()
        
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "Post"
        case delete = "DELETE"
    }
    
}
