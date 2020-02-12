//
//  SearchResultController.swift
//  ITunesSearch
//
//  Created by Nick Nguyen on 2/11/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    enum NetworkError : Error {
        case badURL
        case requestFailed
        case Unknown
    }
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType,completion: @escaping (Error?) -> Void) {
       
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entity = URLQueryItem(name: "entity", value: resultType.rawValue)
        let limitSearch = URLQueryItem(name: "limit", value: "200")
        
        urlComponents?.queryItems = [searchTermQueryItem,entity,limitSearch]
        
        guard let requestURL = urlComponents?.url else {
          NSLog("URL is nil")
            completion(NetworkError.badURL)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        print(request)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NetworkError.requestFailed)
            }
            guard response != nil else {
                NSLog("Error getting response from JSON")
                return
                
            }
            guard let data = data else {
                completion(NetworkError.Unknown)
                NSLog("Can't fetch data")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let ituneSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf:ituneSearch.results)
                completion(nil)
            } catch let err {
                NSLog("Can't decode data :\(err.localizedDescription)")
               
            }
            completion(NetworkError.badURL)
        }
        .resume()
        
    }
    
}
