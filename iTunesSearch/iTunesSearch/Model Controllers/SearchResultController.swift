//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Aaron Peterson on 5/6/20.
//  Copyright © 2020 Aaron Peterson. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    private lazy var baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        
        let searChTermQueryItem = URLQueryItem(name: resultType.rawValue, value: searchTerm)
        urlComponents?.queryItems = [searChTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Requested URL is nil")
            completion()
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion()
                return
            }
            
            guard let self = self else { completion(); return }
            
            guard let data = data else {
                print("N0 data returned from data task.")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResult.results)
            } catch {
                print("Unable to decode data into object of type SearchResult: \(error)")
            }
            
            completion()
        }
        
        task.resume()
    }
}
