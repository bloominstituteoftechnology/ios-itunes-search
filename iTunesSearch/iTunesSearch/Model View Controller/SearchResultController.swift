//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Josh Kocsis on 5/7/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let urlQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let urlQueryItem1 = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [urlQueryItem, urlQueryItem1]
        
        guard let urlRequest = urlComponents?.url else {
            print("Request URL is nil.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error).")
                completion(error)
                return
            }
            
            guard let self = self else {
                completion(nil);
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                completion(error)
            }
        }
        task.resume()
    }
    
}
