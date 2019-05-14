//
//  SearchResultController.swift
//  iTunes
//
//  Created by Hayden Hastings on 5/14/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import Foundation

class SearchResultController {
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        let resultURL = baseURL.appendingPathComponent("results")
        var urlComponents = URLComponents(url: resultURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let formattedURL = urlComponents?.url else { completion(nil)
            return
        }
        
        // We need to create a "request"
        // - url, http method, (optionally) the information to send to the url
        var request = URLRequest(url: formattedURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Perform the request (go to the API)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for results: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let searchResult = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                
                completion(nil)
            } catch {
                NSLog("Error decoding from SearchResults from data: \(error)")
                completion(error)
            }
        }
        
        dataTask.resume()
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
}
