//
//  SearchResultController.swift
//  itunes search
//
//  Created by ronald huston jr on 5/4/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation

protocol SearchResultsDelegate: class {
    func updateTableView()
}

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum selected: String {
        case Apps = "software"
        case Music = "musicTrack"
        case Movies = "movie"
    }
    
    //  MARK: - properties
    weak var delegate: SearchResultsDelegate?
    var searchResults: [SearchResult] = []
    
    //  MARK: - URL
    private let baseURL = URL(string: "https://itunes.apple.com")!
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: baseURL) { data, _, error in
    
            if let error = error {
                print("error getting data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("no data returned from data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results

            } catch {
                NSLog("error")
            }
            
        }
        dataTask.resume()
    }
}
