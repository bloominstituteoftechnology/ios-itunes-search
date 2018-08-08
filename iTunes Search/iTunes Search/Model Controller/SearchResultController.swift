//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Linh Bouniol on 8/7/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults = [SearchResult]()
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(with searchTerm: String, resultType: ResultType, country: String, limit: String, completion: @escaping ([SearchResult]?, Error?) -> Void  ) {
        
        // Adding query item (URLQueryItems) to requestURL using URLComponents
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let countryQueryItem = URLQueryItem(name: "country", value: country)
        let limitQueryItem = URLQueryItem(name: "limit", value: limit)
        
        urlComponents.queryItems = [searchQueryItem, resultQueryItem, countryQueryItem, limitQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
            
                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                let searchResult = results.results
                self.searchResults = searchResult
                completion(searchResult, nil)
            } catch {
                NSLog("Unable to decode data into search result: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
    }
}
