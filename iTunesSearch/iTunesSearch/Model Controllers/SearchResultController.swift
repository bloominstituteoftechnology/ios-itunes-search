//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Jessie Ann Griffin on 9/8/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/")
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case host = "HOST"
        case delete = "DELETE"
    }
        
    func performSearch(with searchTerm: String, type resultType: ResultType, completion: @escaping (Error?) -> Void) {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/search"
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchTermQueryItem, entityItem]
        print(urlComponents)
        guard let requestUrl = urlComponents.url else {
            print("Request URL is nil.")
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned from the data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                print("Unable to decode data into SearchResults object: \(error)")
                completion(error)
            }
        }.resume()
    }
}
