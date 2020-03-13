//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Juan M Mariscal on 3/13/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import Foundation

class SearchResultController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://itunes.apple.com/")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, completion: @escaping ([SearchResult]) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil")
            completion([SearchResult]())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from data task.")
                completion([])
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let resultTypeSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                completion(resultTypeSearch.results)
            } catch {
                print("Unable to decode data: \(error)")
                completion([])
            }
        }.resume()
        
    }
    
}
