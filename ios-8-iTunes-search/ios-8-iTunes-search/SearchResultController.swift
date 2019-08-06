//
//  SearchResultController.swift
//  ios-8-iTunes-search
//
//  Created by Alex Shillingford on 8/6/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = [] // Data source for the tableView
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [searchTermQueryItem, entityQueryItem]
        guard let requestURL = urlComponents?.url else {
            print("No URL Found")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with URLSession.shared.dataTask: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(NSError())
                return
            }
            
            do {
                let termSearch = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults = termSearch.results
                completion(nil)
            } catch {
                print("Could not decode data into type [SearchResult]: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
}
