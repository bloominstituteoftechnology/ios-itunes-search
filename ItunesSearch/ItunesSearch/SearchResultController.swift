//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Clean Mac on 5/6/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    var searchResult: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                print ("error fetching data:\(error)")
                completion()
                return
            }
            
            guard let data = data else {
                print ("No data returned from the data task")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResult = search.results
            } catch {
                print("Unable to decode data into objec of type SearchResult: \(error)")
            }
            
            completion()
        }
        task.resume()
    }
}
