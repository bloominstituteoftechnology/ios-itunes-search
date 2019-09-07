//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Dillon P on 9/7/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search?")
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        guard let baseURL = baseURL else {
            completion(nil)
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion(NSError())
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            guard let data = data else {
                print("No data returned from data task.")
                completion(NSError())
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(NSError())
            } catch {
                print("Unable to decode data into search object: \(error)")
                completion(NSError())
            }
        }.resume()
        
    }
}
