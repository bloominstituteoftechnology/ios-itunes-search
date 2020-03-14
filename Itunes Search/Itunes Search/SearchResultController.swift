//
//  SearchResultController.swift
//  Itunes Search
//
//  Created by Morgan Smith on 1/17/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
       
      let parameters: [String: String] = ["term": searchTerm,
                               "entity": resultType.rawValue]
             
             let queryItems = parameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
             
             urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else {
            return
    }
    
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
