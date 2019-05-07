//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by morse on 5/7/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation


class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchTermQueryType = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchTermQueryItem, searchTermQueryType]
        guard let requestURL = urlComponents?.url else {
            NSLog("requestURL is nil")
            // Completion should be called with nil because it doesn't have access to any errors. Is that right?
            completion(nil)
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                NSLog("Undable to decode data into object of type [SearchResult]: \(error)")
                print(requestURL)
            }
            completion(error)
        }.resume()
    }
}
