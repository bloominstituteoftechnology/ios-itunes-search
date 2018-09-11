//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jason Modisett on 9/11/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class SearchResultController {
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let mediaTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        
        components?.queryItems = [searchTermQueryItem, mediaTypeQueryItem]
        
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
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                switch resultType {
                case .software:
                    let search = try jsonDecoder.decode(AppSearchResults.self, from: data)
                    self.searchResults = search.results
                case .musicTrack:
                    let search = try jsonDecoder.decode(MusicSearchResults.self, from: data)
                    self.searchResults = search.results
                case .movie:
                    let search = try jsonDecoder.decode(MovieSearchResults.self, from: data)
                    self.searchResults = search.results
                }
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    var searchResults: [SearchableResults] = []
    var baseURL = URL(string: "https://itunes.apple.com/search")!
}
