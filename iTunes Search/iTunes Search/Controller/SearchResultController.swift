//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jake Connerly on 6/18/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

class SearchResultController {

    let baseURL = URL(string: "https://itunes.apple.com/search")
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        guard let baseURL = baseURL else {
            print("error unwrapping baseURL")
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("error unwrapping request URL")
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error fetching data: \(error)")
            }
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let iSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = iSearch.results
                completion(nil)
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }

}
