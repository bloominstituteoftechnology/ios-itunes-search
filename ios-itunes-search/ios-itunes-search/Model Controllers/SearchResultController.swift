//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by Conner on 8/7/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search?")!

class SearchResultController {
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        let entityQueryItem = URLQueryItem(name: "entity", value: String(describing: resultType))
        urlComponents.queryItems = [searchQueryItem, entityQueryItem]
        
        guard let requestURL = urlComponents.url else {
            completion(nil, NSError())
            return
        }
        
        print(requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data: No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let searchResultsDecoded = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResultsDecoded.results
                completion(self.searchResults, nil)
            } catch {
                NSLog("Unable to decode data into search results: \(error)")
                completion(nil, error)
                return
            }
            
        }.resume()
    }
}
