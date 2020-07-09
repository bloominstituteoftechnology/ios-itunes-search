//
//  SearchResultController.swift
//  itunes search
//
//  Created by ronald huston jr on 5/4/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation

class SearchResultController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum selected: String {
        case apps = "software"
        case music = "musicTrack"
        case movies = "movie"
    }
    
    //  MARK: - properties
    var searchResults: [SearchResult] = []
    
    
    //  MARK: - URL
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    private var task: URLSessionTask?
    var selectedSegment: selected = .apps
    
    //  MARK: - search function
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQuery = URLQueryItem(name: "term", value: searchTerm)
        let artistQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents.queryItems = [searchQuery, artistQuery]
        
        guard let requestURL = urlComponents.url else {
            NSLog("error in search URL / API")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
    
            if let error = error {
                NSLog("error performing data task: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("no data returned from data task")
                completion(nil, NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = search.results
                completion(self.searchResults, nil)
            } catch {
                NSLog("error decoding data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
