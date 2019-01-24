//
//  SeachResultController.swift
//  iTunes Search
//
//  Created by Moses Robinson on 1/22/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let typeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, typeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("No URL found.")
            completion(NSError())
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("could not find data: \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                NSLog("Could not find data. No data returned.")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let decodedSearchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = decodedSearchResults.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into result: \(error)")
                completion(NSError())
                return
            }
        }
        dataTask.resume()
    }
    
    //MARK: - Properties
    
    var searchResults: [SearchResult] = []
}
