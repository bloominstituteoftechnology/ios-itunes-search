//
//  SearchResultController.swift
//  ios-iTunes-search
//
//  Created by Lambda-School-Loaner-11 on 8/7/18.
//  Copyright © 2018 Lambda-School-Loaner-11. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultsController {
    
    var searchResults: [SearchResult] = []

    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        let entityQuery = URLQueryItem(name: "entity", value: resultType.rawValue)

        
        urlComponents.queryItems = [searchQueryItem, entityQuery]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing URL for \(searchTerm)")
            return
        }
        
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error as NSError? {
                NSLog("Error fetching data \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                completion(NSError())
                NSLog("Error fetching data")
                return
            }
    
            do {
                let jsonDecoder = JSONDecoder()
                
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                
                completion(nil)
            } catch {
                NSLog("Unable to decode data")
                completion(NSError())
            }
        }
        dataTask.resume()
    }
}
