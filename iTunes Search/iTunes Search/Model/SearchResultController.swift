//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 16/03/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseUrl = "https://itunes.apple.com/search"
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        guard let baseUrl = URL(string: baseUrl) else {
            print("URL provided is not a valid URL.")
            return
        }
        
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        
        guard let requestUrl = urlComponents?.url else {
            print("Request URL is not valid")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print("Error fetching data from API")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error with data returned from API.")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                print("Error Decoding JSON data.")
                print("Error retrieving with URL: \(request.url)")
                completion(error)
            }
            
        }.resume()
        
    }
}
