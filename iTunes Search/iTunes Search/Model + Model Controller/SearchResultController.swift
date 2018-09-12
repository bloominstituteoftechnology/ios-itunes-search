//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jason Modisett on 9/11/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class SearchResultController {
    
    func performSearch(with searchTerm: String, resultType: ResultType, searchCountry: SearchCountry = .USA, completion: @escaping (Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchCountryQueryItem = URLQueryItem(name: "country", value: searchCountry.rawValue)
        let mediaTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        let limitTypeQueryItem = URLQueryItem(name: "limit", value: String(10))
        
        components?.queryItems = [searchTermQueryItem, searchCountryQueryItem, mediaTypeQueryItem, limitTypeQueryItem]
        
        guard let requestURL = components?.url else {
            NSLog("requestURL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching iTunes Search API results: \(error)")
                completion(error)
            }
            
            guard let data = data else {
                NSLog("No data returned from iTunes Search API data task")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                switch resultType {
                case .software:
                    let search = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = search.results
                    completion(nil)
                case .music:
                    let search = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = search.results
                    completion(nil)
                case .movie:
                    let search = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = search.results
                    completion(nil)
                }
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    var searchResults: [SearchResult]? = []
    var baseURL = URL(string: "https://itunes.apple.com/search")!
}
