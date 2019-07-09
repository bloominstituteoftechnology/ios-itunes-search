//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Kat Milton on 7/9/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation


class SearchResultController {

    let baseURL = URL(string: "https://itunes.apple.com/search?")!

    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultCategoryQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultCategoryQuery]
        guard let requestURL = urlComponents?.url else {
            NSLog("Request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, result, error in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from task.")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let itunesSearch = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = itunesSearch.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object type [SearchResult]: \(error)")
                completion(error)
                
            }
            completion(nil)
            
        }.resume()
        
        
    }

}
