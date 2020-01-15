//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Aaron Cleveland on 1/14/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (_ error: Error?) -> ()) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion(NSError())
            return
        }
        print("function")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResult.results)
            } catch {
                print("Unable to decode data into objects of type [Results]: \(error)")
            }
            completion(nil)
        }
    .resume()
    }
}
