//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Linh Bouniol on 8/7/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "htts://itunes.apple.com/search/")!
    
    var searchResults = [SearchResult]()
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, NSError?) -> Void  ) {
        
        // Adding query item (URLQueryItems) to requestURL using URLComponents
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error as? NSError)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
            
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let searchResult = searchResults.results
                completion(searchResult, nil)
            } catch {
                NSLog("Unable to decode data into search result: \(error)")
                completion(nil, error as? NSError)
                return
            }
        }.resume()
        
    }
}
