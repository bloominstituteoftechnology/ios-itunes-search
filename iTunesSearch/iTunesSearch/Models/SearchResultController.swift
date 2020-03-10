//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Shawn Gee on 3/10/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private(set) var searchResults: [SearchResult] = []
    
    func performSearch(withTerm searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void ) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: resultType.rawValue)
        ]
        
        guard let requestURL = components?.url else {
            let error = NSError(domain: "Request URL is nil", code: 1)
            completion(error)
            return
        }
        
        print(requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data to decode", code: 2)
                completion(error)
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                completion(error)
            }
            
        }.resume()
        
        
    }
    
    
    //MARK: - Private
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
}
