//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Cameron Collins on 4/6/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import Foundation


class SearchResultController {
    
    //Enumerator
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    //Variables
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    lazy var searchURL = URL(string: "&entity=", relativeTo: baseURL)!
    var task: URLSessionTask?
    var searchResults: [SearchResult] = [] //Data Source
    
    
    //Functions
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        task?.cancel()
        
        //Not sure what this does?
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let searchQueryTerm = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryTerm]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL Nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let self = self else { return }
            guard let data = data else {
                print("No data returned from dataTask")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let search = try jsonDecoder.decode([SearchResult].self, from: data)
                self.searchResults = search
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            completion()
        }
        task?.resume()
    }
    
}
