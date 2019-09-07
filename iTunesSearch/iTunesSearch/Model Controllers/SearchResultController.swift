//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by John Kouris on 9/7/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")
    var searchResults = [SearchResult]()
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        guard let baseURL = baseURL else {
            completion(nil)
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from the data task.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                print("Unable to decode data into SearchResult object: \(error)")
                completion(error)
            }
//            completion(NSError())
            
        }.resume()
        
        
    }
    
    
}

