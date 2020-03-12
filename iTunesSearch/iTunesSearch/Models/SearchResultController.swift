//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Bhawnish Kumar on 3/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

class SearchResultController {
    private(set) var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void ) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
       urlComponents?.queryItems = [ URLQueryItem(name: "term", value: searchTerm),
                                     URLQueryItem(name: "entity", value: resultType.rawValue)
        
        ]
        guard let requestURL = urlComponents?.url else {
        NSLog("request url is nil")
            let error = NSError(domain: "url construction failed", code: 1)
        completion(error)
        return
            
        }
   var request = URLRequest(url: requestURL)
          request.httpMethod = "GET"
        
          URLSession.shared.dataTask(with: request) { (data, _, error) in
              if let error = error {
                  NSLog("Error fetching data \(error)" )
                  completion(error)
                  return
              }
              guard let data = data else { // we want the data to exist so we need to unwrapp it
                  NSLog("No data return from data task ")
                  completion(error)
                  return
              }
              
              do {
                let itunesSearch = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults  = itunesSearch.results
              } catch {
                  NSLog("Unable to decode the data into object of type [SearchResult]: \(error)")
              }
              completion(nil)
          } .resume()
    }
}
