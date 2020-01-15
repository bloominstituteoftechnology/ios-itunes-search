//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Michael on 1/14/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (_ error: (Error?)) -> Void) {
        let searchURL = baseURL.appendingPathComponent("search")
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        guard let requestURL = urlComponents?.url else {
            print("Request URL is Nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        print(request)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                completion(NSError())
                print("No data returned from data task.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let userSearchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: userSearchResults.results)
                completion(nil)
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            completion(nil)
        }.resume()
    }
}
