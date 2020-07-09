//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Dojo on 7/8/20.
//  Copyright © 2020 Dojo. All rights reserved.
//

import UIKit

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        var request = URLRequest(url: URL(string: "url.com")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error fetching data: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                print("no data retruned from data task")
                completion(NSError())
                return
            }
            let jsondDecoder = JSONDecoder()
            jsondDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let searchResults = try jsondDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
            } catch {
                print("Unable to decode data into object of type searchResult: \(error)")
                completion(nil)
                return
            }
            completion(error)
        }
       .resume()
    }
}
