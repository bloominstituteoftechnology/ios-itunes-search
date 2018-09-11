//
//  SearchResultsController.swift
//  ios itunes search
//
//  Created by Moin Uddin on 9/11/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


let exampleURL = "https://itunes.apple.com/search?term=eminem&entity=musicTrack"


class SearchResultsController {
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        let searchUrl = baseURL.appendingPathComponent("search")
        var components = URLComponents(url: searchUrl, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        components?.queryItems = [searchQueryItem]
        
        guard let requestURL = components?.url else {
            NSLog("requestURL is nil")
            completion(NSError())
            return
        }
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            //Turn the data into [Person]
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let termSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = termSearch.results
                completion(NSError())
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(NSError())
                return
            }
        }.resume()
    }
    
    
    
    
    
    let baseURL = URL(string: "https://itunes.apple.com/")!
    var searchResults: [SearchResult] = []
}
