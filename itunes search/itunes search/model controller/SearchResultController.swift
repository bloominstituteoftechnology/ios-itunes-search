//
//  SearchResultController.swift
//  itunes search
//
//  Created by ronald huston jr on 5/4/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation



class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    //  MARK: - properties
    var searchResults: [SearchResult] = []
    
    //  MARK: - URL
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    //  MARK: - search function
    func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchEntityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchTermQueryItem, searchEntityQueryItem]
        
        guard let requestURL = urlComponents.url else {
            print("Request URL is nil")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
    
            if let error = error {
                NSLog("error performing data task: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("no data returned from data task")
                completion(nil, NSError())
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                let decoded = searchResults.results
                completion(decoded, nil)
                
            } catch {
                NSLog("error decoding data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
