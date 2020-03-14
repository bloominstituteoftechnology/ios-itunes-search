//
//  SearchResultController.swift
//  itunesSearch
//
//  Created by Matthew Martindale on 3/12/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
                print("Error: Request URL is nil")
            // TODO: - Completion handler
            completion(nil)
                return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            let apps = ResultType.software
            let music = ResultType.musicTrack
            let movie = ResultType.movie
            
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
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
                completion(nil)
            } catch {
                print("Unable to decode data: \(error)")
                completion(error)
            }
        }.resume()
    }
    
}
