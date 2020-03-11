//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Mark Gerrior on 3/10/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!

    private(set) var searchResults: [SearchResult] = []

    func performSearch(searchTerm: String,
                       resultType: ResultType,
                       twoLetterCountryCode: String,
                       completion: @escaping (Error?) -> Void) {
        
        // Create URL to be used to call the end point.
        // TODO: resolvingAgainstBaseURL means full URL and not relative? 
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let countryQueryItem = URLQueryItem(name: "country", value: twoLetterCountryCode)
        let mediaQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchTermQueryItem, countryQueryItem, mediaQueryItem]
        guard let requestUrl = urlComponents?.url else {
            NSLog("request URL is nil")
            completion(nil)
            return
        }

        // Got the URL, now make turn it into a request.
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET" // Must be all upper-case
        
        // Make the call!
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError()) // TODO: Why NSError?
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let thisSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = thisSearch.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object of type [SearchResults]: \(error)")
                completion(error)
            }
        }.resume()
    }
}
