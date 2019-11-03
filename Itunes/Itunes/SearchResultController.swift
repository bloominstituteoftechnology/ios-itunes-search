//
//  SearchResultController.swift
//  Itunes
//
//  Created by Alex Thompson on 11/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResult: [SearchResult] = []
    func performSearch(searchTerm: String, resultType: ResultType, completetion: @escaping() -> Void) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem1 = URLQueryItem(name: "term", value: searchTerm)
        let searchQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = [searchQueryItem1,searchQueryItem2]
        guard let requestURL = components?.url else {
            print("The request url is nil")
            completetion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: request) { data, response,
            error in
            if let error = error {
                print("Error fethching data: \(error)")
                completetion()
                return
            }
            
            guard let data = data else {
                print("No data returned from data task")
                completetion()
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                self.searchResult = searchResults.results
                self.searchResult.append(contentsOf: searchResults.results)
                completetion()
            } catch {
                print("Unable to decode data: \(error)")
            }
            completetion()
        }
        task.resume()
    }
}
