//
//  SearchResultController.swift
//  Itunes Search
//
//  Created by Morgan Smith on 1/17/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
       
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil!")
            completion(nil)
            return
    }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
               guard error == nil else {
                   print("Error fetching data: \(error!)")
                   completion(error)
                   return
               }
               
               guard let data = data else {
                   print("Error: no data returned from data task")
                   completion(error)
                   return
               }
               
               let jsonDecoder = JSONDecoder()
               
               do {
                   let itunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                   self.searchResults = itunesSearch.results
                    completion(nil)
               } catch {
                   print("Unable to decode data into object of type [SearchResults]: \(error)")
                    completion(error)
               }
           }.resume()
}
}
