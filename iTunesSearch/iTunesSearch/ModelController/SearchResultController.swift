//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Clayton Watkins on 5/6/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Properties
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    var searchResult: [SearchResult] = []
    
    enum HTTPMethod: String {
         case get = "GET"
         case put = "PUT"
         case post = "POST"
         case delete = "DELETE"
    }
    
    // MARK: - Helper Functions
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void){
        // Step 1: Build endpoint URL with query items
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term=", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity=", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion()
            return
        }
        
        // Step 2: Handle URL request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Step 3: Create URL Task
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            
            // Handle error first
            if let error = error{
                print("Error fetching data: \(error)")
                completion()
                return
            }
            
//          guard let self = self else { completion(); return }
            
            // Handle data optionality
            guard let data = data else {
                print("No data returned from the data task")
                completion()
                return
            }
            
            // Create JSON decoder
            let jsonDecoder = JSONDecoder()
            do{
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResult.append(contentsOf: search.results)
            }catch{
                print("Unable to decode data into object of type SearchResult: \(error)")
            }
            
            completion()
        }
        // Step 4: Run URL Task
        task.resume()
    }
}
