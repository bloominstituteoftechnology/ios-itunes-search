//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Bhawnish Kumar on 3/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

class SearchResultController {
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void ) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        guard let requestURL = urlComponents?.url else {
        NSLog("request url is nil")
        completion()
        return }
   var request = URLRequest(url: requestURL)
          request.httpMethod = "GET"
          URLSession.shared.dataTask(with: request) { (data, _, error) in
              if let error = error {
                  NSLog("Error fetching data \(error)" )
                  completion()
                  return
              }
              guard let data = data else { // we want the data to exist so we need to unwrapp it
                  NSLog("No data return from data task ")
                  completion()
                  return
              }
              let jsonDecoder = JSONDecoder()
              do {
                let itunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: itunesSearch.results)
               
              } catch {
                  NSLog("Unable to decode the data into object of type [Person]: \(error)")
              }
              completion()
          } .resume()
    }
}
