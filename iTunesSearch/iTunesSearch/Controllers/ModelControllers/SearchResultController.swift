//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Lambda_School_loaner_226 on 3/15/20.
//  Copyright © 2020 JamesMcDougall. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/")!
    
    private var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        var searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        URLSession.shared.dataTask(with: baseURL) {data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let results = try JSONDecoder().decode([SearchResults].self, from: data)
                completion(results, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
}
