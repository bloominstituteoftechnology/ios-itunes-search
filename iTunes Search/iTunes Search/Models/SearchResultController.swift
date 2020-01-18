//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Sal Amer on 1/17/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
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
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (_ error: Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
               
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
              guard let requestURL = urlComponents?.url else {
                  print("Error: Request URL is nil!")
                  completion(NSError())
                  return
              }
              var request = URLRequest(url: requestURL)
              request.httpMethod = HTTPMethod.get.rawValue
              
              URLSession.shared.dataTask(with: request) { (data, _, error) in
                  guard error == nil else {
                      print("Error fetching data: \(error!)")
                      completion(NSError())
                      return
                  }
                  
                  guard let data = data else {
                      print("Error: No Data returned from data task!")
                      completion(NSError())
                      return
                  }
                  
                  let jsonDecoder = JSONDecoder()
                  do {
                    let searchResult = try jsonDecoder.decode(SearchResult.self, from: data)
                    self.searchResults.append(searchResult)
                  } catch {
                      print("Unable to decode data into object of type [SearchResult]: \(error)")
                  }
                  completion(nil)
              }
              .resume()
    }
}

// https://swapi.co/api/people/?search=r2
//https://itunes.apple.com/search?term=jack+johnson
