//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Chris Dobek on 4/6/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    private var task: URLSessionTask?
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
            task?.cancel()
            var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            let searchQueryItems = URLQueryItem(name: "search", value: searchTerm)
            urlComponents?.queryItems = [searchQueryItems]


            guard let requestURL = urlComponents?.url else {
                NSLog("Request URL is nil")
                return
            }

            var request = URLRequest(url: requestURL)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    NSLog("Error getting data: \(error)")
                    return
                }

                guard let data = data else {
                    completion()
                    return
                }

                let jsonDecoder = JSONDecoder()
                do {
                    let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = searchResult.results
                } catch {
                NSLog("Error unable to decode data: \(error)")
                }
                completion()
            }
            task?.resume()
        }
}
