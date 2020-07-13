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
//    private lazy var searchURL = URL(string: "?term=\(searchTerm.self)&entity=\(ResultType.self)", relativeTo: baseURL)
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        print(searchTerm)
        print(resultType)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        print(urlComponents?.url! ?? nil!)
        print()
        
        guard let requestURL = urlComponents?.url else {
            completion(NSError())
            return
        }
        var request = URLRequest(url: requestURL)
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
            print(data)
            
            let jsonDecoder = JSONDecoder()
           
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
            } catch {
                print("Unable to decode data into object of type searchResult: \(error)")
                completion(error)
                return
            }
            print(self.searchResults)
        }.resume()
        
    }
}
