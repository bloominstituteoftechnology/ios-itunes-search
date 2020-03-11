//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Karen Rodriguez on 3/10/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, limitByUS: Bool?, searchLimit: Int?, completion: @escaping (Error?) -> Void) {
        print("Perform search gets triggered")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let termQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [termQueryItem, entityQueryItem]
        
        if let unwrapAmerica = limitByUS {
            // Just in case
            if unwrapAmerica {
                let usQueryItem = URLQueryItem(name: "country", value: "us")
                urlComponents?.queryItems?.append(usQueryItem)
            }
        }
        
        if let searchLimit = searchLimit {
            let limitQueryItem = URLQueryItem(name: "limit", value: String(searchLimit))
            urlComponents?.queryItems?.append(limitQueryItem)
        }
        
        print("query items get assigned")
        guard let requestURL = urlComponents?.url else {
            NSLog("Failed to generate request url")
            return
        }
        print("Url Gets formed. \(requestURL)")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Boom1")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Boom2")
                completion(NSError())
                return
            }
            
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                print("Pushed results: \(searchResults.results)")
                completion(nil)
            } catch {
                print("Boom3")
                completion(error)
            }
            
            
        }.resume()
    }
}
