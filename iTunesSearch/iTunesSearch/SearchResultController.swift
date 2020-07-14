//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by John McCants on 7/9/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    
    
    func performSearch(searchTerm: String, resultType: ResultType,  completion: @escaping () -> Void ) {
        
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchParameters = ["term" : searchTerm, "entity" : resultType.rawValue]
       
        let queryItems = searchParameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else {
            print("URL is nil")
            completion()
            return
            
        }
        
        var request = URLRequest(url: requestURL)
        
        //Data Task
        let task = URLSession.shared.dataTask(with: request) { [weak self](data, _, error) in
            if let error = error {
                print("error fetching data: \(error)")
                completion()
                return
            }
            
            guard let self = self else { return }
            
            guard let data = data else {
                print("no data")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // Do - Try - Catch Block (Used for methods that THROW an error)
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                print("Unable to decode data into object of type PersonSearch")
            }
            completion()
        }
        
        task.resume()
        
        
        
        
    }
}
