//
//  SearchResultController.swift
//  ITunes Search
//
//  Created by Sean Acres on 6/18/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, countryCode: CountryCode? = nil, limit: Int? = nil, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, entityQueryItem]
        
        if let countryCode = countryCode {
            urlComponents?.queryItems?.append(URLQueryItem(name: "country", value: countryCode.rawValue))
        }
        if let limit = limit {
            urlComponents?.queryItems?.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        
        guard let request = urlComponents?.url else {
            print("Request URL is nil")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error fetching data with: \(error)")
                completion(error)
            }
            
            guard let data = data else {
                print("data from request is nil")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                print("decoding failed with: \(error)")
                completion(error)
            }
        }.resume()
    }
}
