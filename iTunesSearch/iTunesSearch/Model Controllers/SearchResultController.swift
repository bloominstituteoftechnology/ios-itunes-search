//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Jonalynn Masters on 10/1/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import Foundation

class SearchResultController{
    
    let baseURL = URL(string: "https://itunes.apple.com/")! // base url for itunes api
    
    var searchResults: [SearchResult] = [] // data source for the tableView
    
    // MARK: Functions
    
    // function with searchTerm: String, resultType: ResultType, and completion should take an Error? argument and return a void
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ()  -> Void) {
        
        let workingRequestURL = baseURL.appendingPathComponent("result")
        
        var components = URLComponents(url: workingRequestURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchQueryItem]
        
        guard let fullRequestURL = components?.url else {
            completion()
            return
        }
        
        var request = URLRequest(url: fullRequestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching results: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from search")
                completion()
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                let resultSearch = try decoder.decode(SearchResults.self, from: data)
                completion()
                
                self.searchResults = resultSearch.results
                
            } catch {
                
                NSLog("Unable to decode data into SearchResults: \(error)")
            }
            completion()
        }
        dataTask.resume()
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
