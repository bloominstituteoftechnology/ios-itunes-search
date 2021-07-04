//
//  SearchResultsController.swift
//  iTunes Search
//
//  Created by Madison Waters on 9/18/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

//Example URL https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo
// term= & entity=

class SearchResultsController {
    
    private enum HTTPMethod: String {
        case GET = "GET"
        case PUT = "PUT"
        case POST = "POST"
        case DELETE = "DELETE"
        
    }
    
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error? ) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchEntityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let searchLimitQueryItem = URLQueryItem(name: "limit", value: "20")
        urlComponents.queryItems = [searchTermQueryItem, searchEntityQueryItem, searchLimitQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search url for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, NSError())
                return
            }
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResultz = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResultz.results
                completion(self.searchResults, nil)
                
            } catch {
                
                NSLog("Unable to decode data into itunes search results: \(error)")
                completion(nil, NSError())
                return
                
            }
        }
        dataTask.resume()
    }
}


