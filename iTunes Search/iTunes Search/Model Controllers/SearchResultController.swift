//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Alex Shillingford on 6/18/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [searchTermQueryItem]
        guard let requestURL = urlComponents?.url else {
            print("Url returns nil")
            completion(nil) // Unsure why this goes here
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let termSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = termSearch.results
                completion(nil)
            } catch {
                print("Unable to decode data into type [SearchResult]: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
        
    }
}
