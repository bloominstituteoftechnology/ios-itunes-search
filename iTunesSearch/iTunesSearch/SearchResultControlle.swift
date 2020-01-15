//
//  SearchResultControlle.swift
//  iTunesSearch
//
//  Created by Ufuk Türközü on 14.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        let searchURL = baseURL.appendingPathComponent("search")
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let typeOfQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, typeOfQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data : \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
                do {
                    let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults.append(contentsOf: searchResult.results)
                    completion(nil)
                } catch {
                    print("Unable to decode data into object of type [Person]: \(error)")
                    completion(error)
                }
        }.resume()
    }
}
