//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by morse on 10/29/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "entity", value: resultType.rawValue), URLQueryItem(name: "term", value: searchTerm)]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL in nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
    }
    
}
