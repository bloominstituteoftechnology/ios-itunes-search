//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Gerardo Hernandez on 1/21/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
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
    // MARK: - Functions
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil!")
            completion(NSError())
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) {
            (data, urlResponse, error) in
            
            guard error == nil else {
                print("Error fetching data \(error!)")
                completion(error!)
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from data task!")
                completion(NSError())
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                print("Unable to decode data into object of type []: \(error)")
                completion(error)
            }
        }.resume()
    }
}
