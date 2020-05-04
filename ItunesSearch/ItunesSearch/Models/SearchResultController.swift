//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Marissa Gonzales on 5/4/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    var searchResults: [SearchResult] = []
    lazy var searchURL = URL(string: "&entity=", relativeTo: baseURL)!
    var task: URLSessionTask?
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        
        task?.cancel()
        
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion()
                return
            }
            
            guard let data = data else {
                print("Erorr fetching data: \(error!)")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion()
            } catch {
                print("Can not decode data into object of type [SearchResult]: \(error)")
            }
            completion()
        }
        dataTask.resume()
    }
    
}
