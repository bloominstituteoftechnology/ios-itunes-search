//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Nihal Erdal on 4/6/20.
//  Copyright © 2020 Nihal Erdal. All rights reserved.
//

import Foundation

class SearchResultController{
    
    enum HTTPMethod: String{
        
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    let baseURL = URL(string:"https://itunes.apple.com/search?parameterkeyvalue" )!
    
    lazy var searchURL = URL(string: "&", relativeTo: baseURL)!
    
    var task : URLSessionTask?
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        task?.cancel()
        // creat request
        
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
         let urlQueryItems = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [urlQueryItems]
        
        guard let  requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(nil)
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //creat data task
        
        task = URLSession.shared.dataTask(with: request){ [weak self] data, _, error in
            if let error = error {
                print("Error fetching data :\(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data return from dataTask")
                completion(NSError())
                return // how could i use NSError()??
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                
                let search = try jsonDecoder.decode([SearchResult].self, from: data)
                self?.searchResults = search
                completion(nil)
                
            }catch{
                print("Unable to decode data into instance of SearchResults : \(error.localizedDescription)")
                completion(error)
            }
            
           
        }
        
        task?.resume()
    }
}
