//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jordan Christensen on 9/4/19.
//  Copyright © 2019 Mazjap Co Technologies. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        let searchURL = baseURL.appendingPathComponent("search")
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        let resultItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        components?.queryItems = [searchItem, resultItem]
        
        guard let requestURL = components?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for people on line \(#line) in \(#file): \(error)")
                completion(NSError())
            }
            
            guard let data = data else {
                NSLog("No data returned from searching for people")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let resultsOfSearch = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = resultsOfSearch.results
                completion(nil)
            } catch {
                NSLog("Error decoding SearchResults from data on \(#line) in \(#file): \(error)")
                completion(NSError())
            }
        }.resume()
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
}
