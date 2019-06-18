//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Kat Milton on 6/18/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    var searchResults: [SearchResult] = []
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        let newURL: URL = baseURL.appendingPathComponent(resultType.rawValue)
        var urlComponents = URLComponents(url: newURL, resolvingAgainstBaseURL: true)
        let searchTermQueryIem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryIem]
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = resultType.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else {

                print("No data returned from task.")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let itunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = itunesSearch.results
                completion()
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            completion()
        }.resume()
        
    }
}

