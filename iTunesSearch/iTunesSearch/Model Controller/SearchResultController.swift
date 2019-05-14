//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Jeremy Taylor on 5/14/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
     var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, for resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            completion(NSError())
            return
        }
        
        enum HTTPMethod: String {
            case get = "GET"
            case put = "PUT"
            case post = "POST"
            case delete = "DELETE"
        }
        
        print(requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error searching: \(error)")
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
                let results = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = results.results
                completion(nil)
            } catch {
                NSLog("Error decoding SearchResults from data: \(error)")
                completion(error)
            }
        }
        dataTask.resume()
    }
}
