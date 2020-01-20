//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Eoin Lavery on 20/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = "https://itunes.apple.com/search?"
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType:ResultType, completion: @escaping (Error?) -> Void) {
        guard let baseURL = URL(string: baseURL) else { return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryIem = URLQueryItem(name: "media", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryIem]
        
        guard let requestURL = urlComponents?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error: no data returned from the data task!")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                completion(error)
            }
            
        }.resume()
    }
    
}
