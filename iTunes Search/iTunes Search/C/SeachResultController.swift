//
//  SeachResultController.swift
//  iTunes Search
//
//  Created by Nathan Hedgeman on 8/6/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

class SearchResultController {
    
    //Properties
    var searchResults: [SearchResult] = []
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    //Functions
    func performSearch (searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let queryItem = URLQueryItem(name: "term", value: searchTerm)
        let queryItemType = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [queryItem, queryItemType]
        
        guard let request = urlComponents?.url else {
            NSLog("No request URL found")
            completion(NSError())
            return
        }
        
        let requestURL = URLRequest(url: request)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            
            do {
                
                
                let searchResultData = try JSONDecoder().decode(BaseResults.self, from: data)
                
                self.searchResults = searchResultData.result
                
                completion(nil)
            
                
            } catch {
                
                NSLog("Error decoding data: \(error)")
                completion(error)
            }
            
        }.resume()
    }
}
