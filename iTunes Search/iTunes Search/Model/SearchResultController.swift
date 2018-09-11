//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    private(set) var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQuery = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        components?.queryItems = [searchTermQuery, resultTypeQuery]
        
        guard let requestURL = components?.url else {
            NSLog("Couldn't make a request URL.")
            completion(NSError())
            return
        }
        
        
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error with data.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                searchResults = results.results
                completion(nil)
                
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            
            
        }
    }
}
