//
//  SearchResultsController.swift
//  iTunesSearch
//
//  Created by Alex Rhodes on 9/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

class SearchResultsController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func preformSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueuryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        components?.queryItems = [resultTypeQueuryItem, searchItem]
        
        guard let requestURL = components?.url else {
            NSLog("Error unwrapping request URL")
            return
        
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // data task not ran yet
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // check to see that we can connect to the api for search, this is happeneing after the data task has run.
            if let error = error {
                NSLog("Error retrieving searched object: \(error)")
            }
            
            //check to see if we recieved the results from the search
            guard let data = data else {
                NSLog("No data returned from search.")
                completion(nil)
                return
            }
            
            // decode the data
             let decoder = JSONDecoder()
            
            do {
                
                let resultOfSearch = try decoder.decode(SearchResults.self, from: data)
            
                self.searchResults = resultOfSearch.results
                completion(nil)
                
            } catch {
                NSLog("Error retriving the results to your search: \(error)")
                completion(error)
            }
            completion(nil)
            
        }.resume()

    }
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case pose = "POST"
        case delete = "DELETE"
    }
}

