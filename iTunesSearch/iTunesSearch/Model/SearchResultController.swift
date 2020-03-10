//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Wyatt Harrell on 3/10/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class SearchResultsController {
    
    var searchResults: [SearchResult] = []
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchTermQueryItem2 = URLQueryItem(name: "media", value: resultType.rawValue)

        urlComponents?.queryItems = [searchTermQueryItem, searchTermQueryItem2]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("requestURL is nil")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data retunred from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.removeAll()
                self.searchResults.append(contentsOf: searchResults.results)
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object \(error)")
                completion(error)
            }
        }.resume()
    }
}
