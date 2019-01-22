//
//  SearchResultController.swift
//  ItunesSearchApp
//
//  Created by Nelson Gonzalez on 1/22/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!
class SearchResultController {

    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        let entitySearchQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItems, entitySearchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if error != nil {
                NSLog("There is an error fetching data: \(error!.localizedDescription)")
                completion(NSError())
            }
            guard let data = data else {
                NSLog("There is an error fetching data: No data returned")
                completion(NSError())
                return
            }
            
            do {
               let JsonDecoder = JSONDecoder()
                JsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResult = try JsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into people \(NSError())")
                completion(NSError())
                return
            }
        }.resume()
        
        
    }
}
