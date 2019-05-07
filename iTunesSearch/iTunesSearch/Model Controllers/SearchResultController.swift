//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by morse on 5/7/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (/*Error?*/) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchTermQueryType = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // FIXME: Need tofigure out how to search for just a movie, music, or software.
        
        urlComponents?.queryItems = [searchTermQueryItem, searchTermQueryType]
        guard let requestURL = urlComponents?.url else {
            NSLog("requestURL is nil")
            // Is this right?
            completion()
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
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                NSLog("Undable to decode data into object of type [SearchResult]: \(error)")
                print(requestURL)
            }
            completion(/*error*/)
        }.resume()
    }
}
