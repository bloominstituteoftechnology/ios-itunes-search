//
//  SearchResultController.swift
//  itunes Search
//
//  Created by Gi Pyo Kim on 10/1/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch (with searchTerm: String, resultType: ResultType, completion: @escaping(Error?) -> Void) {
        
        // Build out the URL
        let searchURL = baseURL.appendingPathComponent("search")
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let parameters: [String: String] = ["term": searchTerm,
                          "entity": resultType.rawValue]
        
        let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        
//        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
//        let searchTypeQueryTiem = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = queryItems
        guard let requestURL = components?.url else {
            completion(NSError())
            return
        }
        
        // Create a URL Request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Perform the request (with a data task)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle any errors
            if let error = error {
                NSLog("Error fetching \(searchTerm) within \(resultType.rawValue): \(error)")
                completion(error)
                return
            }
            
            // Decode the data
            guard let data = data else {
                NSLog("No data returned from \(searchTerm) within \(resultType.rawValue)")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let searchResult = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                NSLog("Error decoding search results: \(error)")
                completion(error)
            }
        }
        
        dataTask.resume()
        
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
