//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Chris Gonzales on 2/11/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

class SearchResultController{
    
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch (searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQuery = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQuery]
        guard let requestURL = urlComponents?.url else {
            NSLog("Request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        //Do I need a urlResponse?
        URLSession.shared.dataTask(with: request) { (data, _, error) in
      
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            guard let data = data else {
                completion(error)
                return
            }
            let jsonDecoder = JSONDecoder()
            do{
                let librarySearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: librarySearch.results)
                    completion(nil)
            }catch{
                NSLog("Unable to decode into object type [SearchResult]: \(error)")
                completion(error)
            }
            
            completion(nil)
            
        }.resume()
 
    }
    
}
