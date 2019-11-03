//
//  SearchResultController.swift
//  iOSItunesSearch
//
//  Created by denis cedeno on 11/3/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void){
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let mediaTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
            urlComponents?.queryItems = [searchTermQueryItem, mediaTermQueryItem]
        
///hopefully this creates a url like https://itunes.apple.com/search"[searchTerm, mediaTermQueryItem]
/// itunes search example
///To search for only Jack Johnson music videos, your URL would look like the following:
///https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo
        
        
        guard let requestURL = urlComponents?.url else {
               print("request url is nil")
               completion(nil)
               return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
            
        URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Error fetching data: \(error)")
                    completion(error)
                    return
                }
                
                guard let data = data else {
                    print("No data returned from data task.")
                    completion(error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
               
                do {
                    let resultSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults.append(contentsOf: resultSearch.results)
                } catch {
                    print("Unable to decode data into object of type [Person]: \(error)")
                    completion(error)
                }
               completion(nil)
        }.resume()
    }
}
