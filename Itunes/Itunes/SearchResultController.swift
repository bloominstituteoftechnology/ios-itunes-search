//
//  SearchResultController.swift
//  Itunes
//
//  Created by Gladymir Philippe on 7/8/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {

    var searchResults: [SearchResult] = []

    func performSearch(with searchTerm: String, andResult resultType: ResultType, completion:  @escaping ([SearchResult]?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true )!
        let typeSearchQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem, typeSearchQueryItem]

        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }

        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("Error fetching data. No data returned.")
                completion(nil, NSError())
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                
                let decodedResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = decodedResults.results
                completion(self.searchResults, nil)
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil, error)
                return
            }

        }
        dataTask.resume()

        }

    }

