//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Bree Jeune on 3/17/20.
//  Copyright © 2020 Young. All rights reserved.
//

import Foundation

class SearchResultController {
    var searchResults: [SearchResult] = []

    let baseURL = URL(string: "https://itunes.apple.com/search")!

    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let countryQueryItem = URLQueryItem(name: "country", value: "US")
        urlComponents?.queryItems = [searchTermQueryItem, entityTermQueryItem, countryQueryItem]

        print("SEARCH TERM: \(searchTerm)")
        print("urlComponents: \(urlComponents)")
        print("SEARCH TERM QUERY: \(searchTermQueryItem)")

        guard let requestURL = urlComponents?.url else {
            NSLog("request URL is nil")
            completion()
            return
        }

        print("REQUEST URL: \(requestURL)")

        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("error catching \(error)")
                completion()
                return
            }

            guard let data = data else {
                NSLog("No data in the datatask")
                return
            }

            let jsonDecoder = JSONDecoder()
            do {
                let theSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: theSearch.results)
            } catch {
                NSLog("Unable to decode data into object of type [Person]: \(error)")
            }
            completion()

        }.resume()

    }
}
