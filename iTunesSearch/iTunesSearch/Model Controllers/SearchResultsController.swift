//
//  SearchResultsController.swift
//  iTunesSearch
//
//  Created by Christopher Aronson on 5/7/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class SearchResultsController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQuery = URLQueryItem(name: "term", value: searchTerm)
        let searchTypeQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQuery, searchTypeQuery]
        
        guard let resultURL = urlComponents?.url else {
            NSLog("Errot getting url:")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: resultURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = search.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data")
                completion(error)
            }
            
            
        }.resume()
    }
    
}
