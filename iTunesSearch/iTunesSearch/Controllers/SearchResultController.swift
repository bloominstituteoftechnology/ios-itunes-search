//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Shawn James on 4/6/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults = [SearchResult]()
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let countryQueryItem = URLQueryItem(name: "country", value: "US")
        urlComponents?.queryItems = [searchQueryItem, entityTermQueryItem, countryQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from dataTask")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
            } catch {
                print("Unable to decode data into instance of PersonSearch: \(error.localizedDescription)")
            }
            
            completion()
            
        } .resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
