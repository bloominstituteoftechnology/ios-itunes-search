//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Hunter Oppel on 4/6/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: Properties
    
    var searchResults = [SearchResult]()
    
    private let baseURL = URL(string: "https://itunes.apple.com")!
    private var task: URLSessionTask?
    
    // MARK: - Actions
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        task?.cancel()
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
//        guard let requestURL = urlComponents?.url else {
//            print("Request url is nil")
//            completion(nil)
//            return
//        }
        
//        var request = URLRequest(url: requestURL)
        
        task = URLSession.shared.dataTask(with: baseURL) { [weak self] data, _, error in
            // Optional Handling
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(error)
                return
            }
            guard let self = self else { return }
            guard let data = data else {
                print("No data returned from dataTask.")
                completion(NSError())
                return
            }
            
            // Decoding
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                completion(error)
            }
        }
        
        task?.resume()
    }
}
