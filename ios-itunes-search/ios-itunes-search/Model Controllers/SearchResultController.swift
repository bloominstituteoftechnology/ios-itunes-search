//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by De MicheliStefano on 07.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    
    private enum HTTPMethod: String {
        // enum names by convention should be lowercase
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchTermQueryItem, entityQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Error occured while constructing URL: \(searchTerm)")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if error != nil {
                NSLog("Error occured while fetching from iTunes: \(String(describing: error))")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error occured while fetching from iTunes for data")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(SearchResults.self, from: data)
                let result = results.results
                self.searchResults = result
                completion(nil)
                
            } catch {
                NSLog("Error occured while fetching from iTunes: \(error)")
                completion(error)
                return
            }
        }
        
        dataTask.resume()
    }
    
    // TODO: Create a generic URLBuilder method that takes in baseurl, search querys and returns the request url
    
    var searchResults: [SearchResult] = []
    
}
