//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by Ahava on 5/1/20.
//  Copyright © 2020 Ahava. All rights reserved.
//

import Foundation

class SearchResultController {
    
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entitiyItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        components?.queryItems = [searchQueryItem, entitiyItem]
        
        guard let requestURL = components?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from search")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                
                self.searchResults = searchResults.results
                completion(nil)
                
            } catch {
                print("Request: \(request)")
//                print(String(data: data, encoding: .utf8))
                NSLog("Unable to decode data into SearchResults: \(error)")
                completion(error)
            }
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
