//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Vincent Hoang on 5/4/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import os.log

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com")
    private lazy var searchEndPoint = URL(string: "/search", relativeTo: baseURL)!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        searchResults.removeAll()
        
        var urlComponents = URLComponents(url: searchEndPoint, resolvingAgainstBaseURL: true)
        
        let sanitizedSearch = sanitizeText(inputString: searchTerm)
        let searchQuery = URLQueryItem(name: "term", value: sanitizedSearch)
        let searchType = URLQueryItem(name: "media", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchQuery, searchType]
        
        guard let requestURL = urlComponents?.url else {
            os_log("Request URL is nil", log: OSLog.default, type: .error)
            return
        }
        
        os_log("%@", log: OSLog.default, type: .debug, "\(requestURL.absoluteString)")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                os_log("Error fetching data: %@", log: OSLog.default, type: .error, "\(error)")
                return
            }
            
            guard let data = data else {
                os_log("No data returned from data task.", log: OSLog.default, type: .error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResult.results)
                completion()
            } catch {
                os_log("Unable to decode data into object of type SearchResult: %@", log: OSLog.default, type: .error, "\(error)")
            }
        }
        
        task.resume()
    }
    
    func sanitizeText(inputString: String) -> String {
        let components = inputString.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        
        return components.filter{ !$0.isEmpty }.joined(separator: "+").lowercased()
    }
}
