//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Scott Bennett on 9/18/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var searchResults: [SearchResult] = []


    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        // Setup the URL
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // urlComponents is an array of queries
        urlComponents.queryItems = [searchQueryItem, entityItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        // Creat Data Task
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data retrieved.")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = search.results
                completion(self.searchResults, nil)
                
            } catch {
                NSLog("Unable to decode data into result: \(error)")
                completion(nil, NSError())
                return
            }
        }
        dataTask.resume()
    }
    
}
