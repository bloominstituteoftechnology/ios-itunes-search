//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Sammy Alvarado on 7/8/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation

class SearchResultController {

    enum HTTPMethod: String {
        case get = "Get"
    }

    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []

    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {

        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItems = URLQueryItem(name: "term", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItems]
//        let error = NSError()
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(nil)
            return
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue



        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }

            guard let self = self else {
                completion(error)
                return
            }

            guard let data = data else {
                print("No data returned from data task")
                completion(error)
                return
            }

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let termSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: termSearch.results)
                completion(nil)
            } catch {
                print("Unable to decode data into object of type SearchReslut \(error)")
                completion(error)
                return
            }
            completion(error)
        }

        .resume()

    }



}



