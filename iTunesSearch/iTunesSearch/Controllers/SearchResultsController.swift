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
    private let baseURL = URL(string: "https://itunes.apple.com")!
    private(set) var searchResults: [SearchResult] = []
    
    
    // MARK: - Methods
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping Error? -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        guard let requestURL = urlComponents?.url else {
            NSLog("request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                NSLog("No data return from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResult.results)
                completion(nil)
            } catch {
                NSLog("Unable  to decode data into object of type [Person]: \(error)")
                completion(NSError())
            }
        }.resume()
    }
}
