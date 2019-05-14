//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Mitchell Budge on 5/14/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var results: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(with searchTerm: String, and resultType: ResultType, completion: @escaping (Error?) -> Void) {
        //let searchResultsURL = baseURL.appendingPathComponent("results")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        guard let formattedURL = urlComponents?.url else {
            completion(nil)
            return
        }
        var request = URLRequest(url: formattedURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for people: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("Error retrieving data")
                completion(error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.results = searchResults.results
                completion(nil)
            } catch {
                NSLog("Error decoing SearchResults from data: \(error)")
                completion(error)
            }
        }
        dataTask.resume()
    } // end of perform search function
    
}
