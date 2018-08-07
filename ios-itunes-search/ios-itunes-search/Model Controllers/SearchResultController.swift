//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by Conner on 8/7/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/")!

class SearchResultController {
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents.url else {
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let searchResultsDecoded = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResultsDecoded.results
                completion(searchResultsDecoded.results, nil)
            } catch {
                completion(nil, error)
                return
            }
            
        }.resume()
    }
}
