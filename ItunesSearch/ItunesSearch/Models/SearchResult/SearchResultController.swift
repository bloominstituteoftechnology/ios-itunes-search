//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by brian vilchez on 9/4/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults:[SearchResult] = []
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    
    func performSearch(with searchTerm: String, resultType: ResultType,completion: @escaping() -> Void) {
        let SearchURL = baseURL.appendingPathComponent("")
        var components = URLComponents(url: SearchURL, resolvingAgainstBaseURL: true)
        let searchItem  = URLQueryItem(name: "search", value: searchTerm)
        components?.queryItems = [searchItem]
        
        guard let requestURL = components?.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            
            if let error = error {
                print("error searchng for Item: \(error)")
            }
            guard let data = data else {
                NSLog("no data returned from searching.")
                return
            }
            do {
                let decoder = JSONDecoder()
                let itunesSearch = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = itunesSearch.results
            } catch {
                NSLog("Error decoding itunesSearch from data: \(error)")
            }
            
        }).resume()
    }
    
    enum HTTPMethod:String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    
}


