//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Cora Jacobson on 7/8/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResult: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, limit: Int, completion: @escaping (Error?) -> Void) {

        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let limitQueryItem = URLQueryItem(name: "limit", value: String(limit))
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem, limitQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil.")
            completion(nil)
            return
        }
        
        // URL Request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Data Task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }
            guard let self = self else {
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data returned from data task.")
                completion(NSError())
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResult = search.results
                completion(nil)
            } catch {
                print("Unable to decode data into object of type SearchResult: \(error)")
                completion(error)
                return
            }
        }
        task.resume()
    }
    
}
