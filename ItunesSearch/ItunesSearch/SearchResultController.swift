//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Jonathan Ferrer on 5/14/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class SearchResultController {

    func performSearch(for searchTerm: String, ofType  resultType: ResultType, completion: @escaping () -> Void) {

        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let mediaQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)

        urlComponents?.queryItems = [searchQueryItem, mediaQueryItem]

        guard let formattedURL = urlComponents?.url else {
            completion()
            return
        }
        var request = URLRequest(url: formattedURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                NSLog("Error searching: \(error)")
                completion()
                return
            }

            guard let data = data else {
                NSLog("No data has returned from the data task")
                completion()
                return
            }

            do {
                let decoder = JSONDecoder()
                let iTunesSearch = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = iTunesSearch.results
                completion()
            } catch {
                NSLog("Error decoding SearchResults from data: \(error)")
                completion()
            }
        }

        dataTask.resume()
    }




    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    let baseURL = URL(string: "https://itunes.apple.com/search/")!
    var searchResults: [SearchResult] = []
}
