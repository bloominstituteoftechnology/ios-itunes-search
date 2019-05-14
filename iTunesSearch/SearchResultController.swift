//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Ryan Murphy on 5/14/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation


class SearchResultController {
    
    var searchResults: [SearchResult] = []
    let baseURL = URL(string:"https://itunes.apple.com/search")!

    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping () -> Void)  {
        //set up URL to go to the right place in the API.
        // https://itunes.apple.com/search
    
        
    
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let formattedURL = urlComponents?.url else {
            completion()
            return
        }
    
        var request = URLRequest(url: formattedURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Perform the request
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // any errors from the API?
            if let error = error {
                NSLog("Error Searching for data: \(error)")
                completion()
                return
            }
            //make sure we received data
            guard let data = data else {
                NSLog("No data returned from task")
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataSearch = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = dataSearch.results
                
                completion()
            } catch {
                NSLog ("Error decoding Search Results from data: \(error)")
                completion()
            
            }
            
            
            
            
            
            }
            dataTask.resume()
    }
            
            
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
            
            
        }
        
        
        
        
        
        
        
        

    
    
    
    
    
    


