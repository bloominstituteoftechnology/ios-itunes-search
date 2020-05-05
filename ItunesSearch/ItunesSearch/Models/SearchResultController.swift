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
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        searchResults = []
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTerm = URLQueryItem(name: "term", value: searchTerm)
        let resultType = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = [searchTerm, resultType]
        
        guard let requestURL = components?.url else {
            print("Error getting URL request")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error collecting data: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error collecting data: \(error)")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                
                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = results.results
                completion(nil)
                
            } catch {
                print("Error decoding data: \(error)")
                return
            }
        }
    .resume()
    }
}
