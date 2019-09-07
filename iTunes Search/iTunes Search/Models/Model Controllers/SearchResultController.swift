//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 06/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")
    var searchResults: [SearchResult] = []
    
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
        let mediaTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, mediaTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print(request)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching results: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data return from query")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let resultSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = resultSearch.results
                completion(nil)
            } catch {
                print("Error obtaining JSON Data: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
        
    }
}
