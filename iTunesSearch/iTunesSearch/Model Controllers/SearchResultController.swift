//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Ciara Beitel on 9/3/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        let fullRequestURL = baseURL.appendingPathComponent("search")
        var components = URLComponents(url: fullRequestURL, resolvingAgainstBaseURL: true)
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        components?.queryItems = [searchItem]
        
        guard let requestURL = components?.url else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                NSLog("Error searching for term: \(error), on line \(#line) in \(#file)")
                completion(error)
            }
            guard let data = data else {
                NSLog("No data returned from searching for term")
                completion(NSError())
                return
            }
            do {
                let decoder = JSONDecoder()
                let termSearch = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = termSearch.results
                completion(nil)
            } catch {
                NSLog("Error decoding SearchResults from data: \(error)")
                completion(error)
            }
        }
            
    }
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
}
