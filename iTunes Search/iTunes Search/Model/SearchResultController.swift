//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Chad Parker on 3/13/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    private(set) var searchResults: [SearchResult] = []
    
    func performSearch(_ searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "term", value: searchTerm)]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: requestURL)) { data, _, error in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion(error!)
                return
            }
            guard let data = data else {
                print("Error: no data from data task")
                completion(NSError())
                return
            }
            
            do {
                self.searchResults = try JSONDecoder().decode(SearchResults.self, from: data).results
                completion(nil)
            } catch {
                print("Unable to decode data: \(error)")
                completion(error)
            }
        }.resume()
    }
}
