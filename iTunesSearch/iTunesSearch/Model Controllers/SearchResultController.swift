//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Jeffrey Carpenter on 5/7/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults = [SearchResult]()
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let countryQueryItem = URLQueryItem(name: "country", value: "US")
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, countryQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("requestURL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let decodedResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = decodedResults.results
            } catch {
                NSLog("Unable to decode data into object of type [SearchResult]: \(error.localizedDescription)")
            }
            
            completion()
        }.resume()
    }
}
