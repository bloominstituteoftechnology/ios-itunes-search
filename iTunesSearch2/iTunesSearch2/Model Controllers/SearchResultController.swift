//
//  SearchResultController.swift
//  iTunesSearch2
//
//  Created by Clean Mac on 7/8/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "http://itunes.apple.com/search")!
    // private lazy var searchURL = URL(string: "/search", relativeTo: baseURL)!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItems = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItems]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL nil")
            completion(NSError())
            return
        }
        // URL REQUEST
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        // DATA TASK
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let self = self else {
                completion(error)
                return
            }
            
            
            guard let data = data else {
                print("no data from data task")
                completion(error)
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            //TEST JSON (IS IT WORKING?)
            let json = try! JSONSerialization.jsonObject(with: data)
            print(json)
            
            do {
                let thisSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = thisSearch.results
            } catch {
                print("unable to decode \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        
        task.resume()
    }
    
    
}



