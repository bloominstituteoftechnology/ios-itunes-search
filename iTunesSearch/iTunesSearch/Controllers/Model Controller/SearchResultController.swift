//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Tobi Kuyoro on 11/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com")!
    var searchResults: [SearchResult] = []
    
    func performSearch(for searchTerm: String, ofType resultType: ResultType, completion: @escaping (Error?) -> ()) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let termQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let typeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [termQueryItem, typeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error getting iTunes results: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data from request")
                completion(error)
                return
            }
            
            do {
                let iTunesResults = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults = iTunesResults.results
            } catch {
                print("Error decoding results from iTunes: \(error)")
                return
            }
            completion(nil)
        }.resume()
    }
}
