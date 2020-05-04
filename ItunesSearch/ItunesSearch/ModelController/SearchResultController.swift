//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Nonye on 5/4/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        //MARK: - CREATE REQUEST FOR URL
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        //let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        let parameters: [String : String] = ["term" : searchTerm, ]
        
        //urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //MARK: - DATA TASK
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data \(error)")
                return
            }
            guard let data = data else {
                completion()
                return
                
            }
            
            //MARK: - DECODING
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
            } catch {
                NSLog("Unable to decode data \(error)")
                
            }
            completion()
        }
        .resume()
    }
}
