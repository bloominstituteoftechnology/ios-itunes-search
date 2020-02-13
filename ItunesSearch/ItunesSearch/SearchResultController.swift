//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Keri Levesque on 2/11/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")! // base URL for the itunes search API
    
    var searchResults: [SearchResult] = [] // data source for the table view

    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        // create a URL components objects from our base URL
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)

        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
       
        guard let requestURL = urlComponents?.url else {
                  print("request URL is nil")
                  completion(NSError())
                  return
              }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
             if let error = error {
                 print("Error fetching data: \(error)")
                 return
             }
             guard let data = data else {
                 NSLog("No data returned from the data task")
                 return
             }
             let jsonDecoder = JSONDecoder()
             do {
                 let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
             } catch {
                 NSLog("Unable to decode data into object of type [SearchResult]: \(error)")
             }
             completion(nil)
        }.resume()

    }
}
