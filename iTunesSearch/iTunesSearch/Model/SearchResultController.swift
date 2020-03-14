//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Claudia Contreras on 3/13/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void){
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchMediaQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, searchMediaQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Error: Rquest URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                NSLog("Error fetching data: \(error!)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data return from data task")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let dataSearchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: dataSearchResults.results)
            } catch {
                NSLog("Unable to decode data: \(error)")
            }
            completion()
            
        }.resume()
        
    }
}
