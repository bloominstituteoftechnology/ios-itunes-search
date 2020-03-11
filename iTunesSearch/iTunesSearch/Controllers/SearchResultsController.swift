//
//  SearchResultsController.swift
//  iTunesSearch
//
//  Created by Lambda_School_Loaner_259 on 3/10/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation


class SearchResultsController {
    
    // MARK: - Properties
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    
    // MARK: - Methods
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        //let searchTerm = "term=\(searchTerm)"
//        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
//        let entityResult = URLQueryItem(name: "entity", value: resultType.rawValue)
//        urlComponents?.queryItems = [searchTermQueryItem, entityResult]
        let parameters: [String: String] = ["term": searchTerm,
                          "entity": resultType.rawValue]
        let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        urlComponents?.queryItems = queryItems
        guard let requestURL = urlComponents?.url else {
            NSLog("request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                completion();
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
            } catch {
                NSLog("Unable  to decode data into object of type [SearchResult]: \(error)")
            }
            completion()
        }.resume()
    }
}
