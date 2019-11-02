//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Joseph Rogers on 11/1/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController{
    
    //MARK: Properties
    //data source for the table view
    var searchResults: [SearchResult] = []
    
    
    
    
    
    //MARK: Networking
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    //MARK: Neworking Method Call
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
               let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
               urlComponents?.queryItems = [searchTermQueryItem]
               guard let requestURL = urlComponents?.url else {
                   print("request URL is nil")
                   completion()
                   return
               }
               
               var request = URLRequest(url: requestURL)
               request.httpMethod = HTTPMethod.get.rawValue
               
               URLSession.shared.dataTask(with: request) { data, _, error in
                   if let error = error {
                       print("Error fetching data: \(error)")
                       return
                   }
                   guard let data = data else {
                       print("No data returned from data Task")
                       return
                   }

                   let jsonDecoder = JSONDecoder()
                   jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                   do{
                    let iTunesSearch = try jsonDecoder.decode(SearchResult.SearchResults.self, from: data)
                    self.searchResults.append(contentsOf: iTunesSearch.results)
                   } catch {
                       print("Unable to decode data into object of type [SearchResults]: \(error)")
                   }
                   completion()
               }.resume()
           }
    }


