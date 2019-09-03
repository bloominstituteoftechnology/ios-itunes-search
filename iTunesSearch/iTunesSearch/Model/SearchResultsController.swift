//
//  SearchResultsController.swift
//  iTunesSearch
//
//  Created by Alex Rhodes on 9/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

class SearchResultsController {
    
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []
    
    func preformSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        let appendSearchURL = baseURL.appendingPathComponent("search")
        
        var components = URLComponents(url: appendSearchURL, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchItem]
        
        guard let requestURL = components?.url else {
            completion(nil)
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
            do {
                
                let decoder = JSONDecoder()
                
                let resultOfSearch = try decoder.decode(SearchResult.self, from: data)
                
                #warning("This could not be right lmao")
                self.searchResults = [resultOfSearch]
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

