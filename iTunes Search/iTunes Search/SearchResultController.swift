//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Simon Elhoej Steinmejer on 07/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation


class SearchResultController
{
    private enum HTTPMethod: String
    {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults = [SearchResult]()
    
    func performSeach(with searchTerm: String, resultType: ResultType, searchLimit: Int, completion: @escaping (NSError?) -> ())
    {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let termQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let searchLimitQueryItem = URLQueryItem(name: "limit", value: String(searchLimit))
        urlComponents.queryItems = [searchQueryItem, termQueryItem, searchLimitQueryItem]
        
        guard let urlRequest = urlComponents.url else {
            NSLog("Failed to create URL request")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error
            {
                NSLog("Error fetching data: \(error)")
                completion(error as NSError)
                return
            }
            
            guard let data = data else
            {
                NSLog("Error fetching data")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                NSLog("Error decoding data")
                completion(NSError())
                return
            }
        }.resume()
        
    }
    
}




















