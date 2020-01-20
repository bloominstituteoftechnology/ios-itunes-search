//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by David Wright on 1/17/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Private Methods

    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil!")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                NSLog("Error fetching data: \(error!)")
                completion(error!)
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data returned from data task!")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results.filter { $0.title != nil }
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(error)
            }
        }.resume()
    }
    
}
