//
//  SearchResultController.swift
//  iTunesSearchApp
//
//  Created by Mark Poggi on 4/6/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let parameter: [String: String] = ["term": searchTerm, "entity": resultType.rawValue]
        
        let queryItems = parameter.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error { NSLog("Error fetching data: \(error)") }
            guard let data = data else { completion(); return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            
            completion()
        }
        dataTask.resume()
    }
    
}

