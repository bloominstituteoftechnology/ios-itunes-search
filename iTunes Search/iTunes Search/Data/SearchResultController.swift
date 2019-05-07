//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Sameera Leola on 12/12/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: Data source
    private(set) var searchResult: [SearchResult] = []
    
    static let shared = SearchResultController()
    private init () {}
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        //Create the components
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) // <- resolvingAgainstBaseURLT is always true
        
        // Create the necessary iTunes query parameters in the form of URLQueryItem
        let queryItemSearchTerm = URLQueryItem(name: "term", value: searchTerm)
        let queryItemCountry = URLQueryItem(name: "country", value: "US")
        let queryItemEntity = URLQueryItem(name: "entity", value: resultType.rawValue)
        let queryItemLimit = URLQueryItem(name: "limit", value: "20")
        let queryItemLanguage = URLQueryItem(name: "lang", value: "en_us")
        
        //components?.queryItems = [queryItemSearchTerm, queryItemCountry, queryItemEntity, queryItemArtWork, queryItemLimit, queryItemLanguage]
        components?.queryItems = [queryItemSearchTerm, queryItemCountry, queryItemEntity, queryItemLimit, queryItemLanguage]
        
        //Create the URL
        guard let requestURL = components?.url else {
            NSLog("Unable to make iTunes search request URL")
            completion(NSError())
            return
        }
        
        //Make the request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching iTunes data: \(error)")
                completion(nil)
                return
            }
            
            //No data
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            //Decode the data
            do {
                let itunesData = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResult = itunesData.results
                completion(nil)
                return
            }
            catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil)
                return
            }
        }
        
        dataTask.resume()
    }  //End of search
    
} //End of class
