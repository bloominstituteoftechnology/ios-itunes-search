//
//  SearchResultController.swift
//  ios-iTunes-search
//
//  Created by Lambda-School-Loaner-11 on 8/7/18.
//  Copyright © 2018 Lambda-School-Loaner-11. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultsController {
    
    var searchResults: [SearchResult] = []

    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void?) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents!.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents!.url else {
            NSLog("Problem constructing URL for \(searchTerm)")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error as NSError? {
                NSLog("Error fetching data \(error)")
                completion(self.searchResults, error)
            }
            guard let data = data else { return }
            NSLog("Error fetching data")
            completion(nil, NSError())
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let search = searchResults.results
                completion(search, nil)
            } catch {
                NSLog("Unable to decode data")
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
