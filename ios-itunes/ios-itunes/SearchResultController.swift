//
//  SearchResultController.swift
//  ios-itunes
//
//  Created by Angel Buenrostro on 1/22/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?term=")!

    var searchResults: [SearchResult] = [] // This will be datasource for the tableview

    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) {data, erroneous, error in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned.")
                completion(NSError())
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .useDefaultKeys
                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = results.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into searchResults: \(error)")
                completion(nil)
                return
            }
        }.resume
}
}
