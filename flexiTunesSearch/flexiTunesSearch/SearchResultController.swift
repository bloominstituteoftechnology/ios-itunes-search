//
//  SearchResultController.swift
//  flexiTunesSearch
//
//  Created by admin on 10/1/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        let searchURL = baseURL.appendingPathComponent("searchResults") //Not sure about this
        
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchQueryItem]
        
        guard let requestURL = components?.url else {
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching search result: \(error)")
                completion()
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let searchResult = try decoder.decode(SearchResults.self, from: data!)
                self.searchResults = searchResult.results
            } catch {
                NSLog("Unable to decode data in SearchResults: \(error)")
                //Unsure about NSError()
            }
            completion()
        }
        
        dataTask.resume()
        
        
    }
    
    
}
