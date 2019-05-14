//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Kobe McKee on 5/14/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var results: [SearchResult] = []
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let formattedURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: formattedURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error searching iTunes \(error)")
                completion(error)
                return
            }
            
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(error)
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.results = searchResults.results
                
                completion(nil)
            } catch {
                NSLog("Error decoding SearchResults from data: \(error)")
                completion(error)
            }
        }
        
        dataTask.resume()
        
    }
    
}

