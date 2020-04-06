//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Nichole Davidson on 4/6/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

class SearchResultController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Properties
    
    var searchResults: [SearchResult] = []
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    private var task: URLSessionTask?
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        task?.cancel()
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem1 = URLQueryItem(name: "term", value: searchTerm)
        let searchQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem1, searchQueryItem2]
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let self = self else { return }
            
            guard let data = data else {
                print("No data returned from dataTask")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let itunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = itunesSearch.results
                completion(nil)
            } catch {
                print("Unable to decode data into instance of SearchResults: \(error.localizedDescription)")
                completion(error)
            }
            
        }
        
        task?.resume()
    }
}
