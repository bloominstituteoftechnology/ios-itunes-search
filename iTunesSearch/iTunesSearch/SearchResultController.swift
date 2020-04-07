//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Harmony Radley on 4/6/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String{
        
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var searchResults: [SearchResult] = []
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    private var task: URLSessionTask?
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        task?.cancel()
        
        // create request
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(nil)
            return
        }
        print(urlComponents?.url) // insomnia
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Create data task
                                // background thread
        task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let self = self else { return }
            guard let data = data else {
                print("No data returned from dataTask")
                return
            }
            
            // Decoding
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                print("Unable to decode data into instance of SearchResults: \(error.localizedDescription)")
                
            }
            
            completion(nil)
        }
        
        task?.resume()
        
    }
}
