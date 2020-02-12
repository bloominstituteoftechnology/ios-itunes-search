//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Elizabeth Wingate on 2/11/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
          case get = "GET"
          case put = "PUT"
          case post = "POST"
          case delete = "DELETE"
      }
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
         var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
     let searchEntityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, searchEntityQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print ("request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
            NSLog("Error fetching data: \(error)")
            completion(nil)
            return
        }
        guard let data = data else {
        NSLog("No data returned from data task.")
            completion(nil)
            return
         }
        let jsonDecoder = JSONDecoder()
         do {
        let searchResult = try jsonDecoder.decode(SearchResult.self, from: data)
            self.searchResults = searchResult.results
             print (self.searchResults)
                   } catch {
             print("Unable to decode data into object of type [SearchResult]: \(error)")

        }
        DispatchQueue.main.async {
        completion(nil)
         }
        }.resume()
    }
}
