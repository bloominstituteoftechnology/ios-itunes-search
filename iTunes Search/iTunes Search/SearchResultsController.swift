//
//  SearchResultsController.swift
//  iTunes Search
//
//  Created by Jeremy Taylor on 8/7/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class SearchResultsController {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    private enum HTTPMethod: String {
        case get = "GET"
    }
    
    func performSearch(with searchTerm: String?, resultType: ResultType?, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "media", value: resultType?.rawValue)
        urlComponents.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing URL for search term: \(String(describing: searchTerm)) and result type: \(String(describing: resultType?.rawValue))")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                let searchResults = results.results
                completion(searchResults, nil)
                
                
            } catch {
                NSLog("Unable to decode data into search results: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
