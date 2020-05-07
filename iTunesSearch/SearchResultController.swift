//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Kenneth Jones on 5/6/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://itunes.apple.com/search?")!
    private lazy var softwareURL = URL(string: "entity=\(ResultType.software)&", relativeTo: baseURL)!
    private lazy var musicURL = URL(string: "entity=\(ResultType.musicTrack)&", relativeTo: baseURL)!
    private lazy var movieURL = URL(string: "entity=\(ResultType.movie)&", relativeTo: baseURL)!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: softwareURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let self = self else { completion(NSError()); return }
            
            guard let data = data else {
                print("no data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
                completion(nil)
            } catch {
                print("Unable to decode data into object of type SearchResults: \(error)")
                completion(error)
            }
        }
        task.resume()
    }
}
