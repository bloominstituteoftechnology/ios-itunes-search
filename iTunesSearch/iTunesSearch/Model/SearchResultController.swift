//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Ian French on 5/6/20.
//  Copyright © 2020 Ian French. All rights reserved.
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
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
     // Step 1: Build endpoint URL with query items
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        let resultsTermQueryItem = URLQueryItem(name: "results", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchTermQueryItem, resultsTermQueryItem]
      
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
      
        // Step 2: Create URL Request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Step 3: Create URL Task
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
           
            
            // Handle Error first
            if let error = error {
                print("Error fetching data: \(error)")
                completion()
                return
            }
            
      
            
            // Handle Data Optionality
            guard let data = data else {
                print("no data returned from data task.")
                completion()
                return
            }
            
         // Create Decoder
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    // Decode and adding objects to array
                    do {
                        let basicSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                        self.searchResults = basicSearch.results
                    } catch {
                        print("Unable to decode data into object of type PersonSearch: \(error)")
                    }
                    
                    completion()
                }
                
                // Step 4: Run URL Task
                task.resume()
            }
        }

        
        
        
        
        
        
        
        
        
        
  }


}
