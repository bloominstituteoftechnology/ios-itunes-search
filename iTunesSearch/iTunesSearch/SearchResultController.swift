//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Harm on 5/2/23.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    private let baseURL = URL(string: "https://itunes.apple.com")!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryTerm = URLQueryItem(name: "/search?", value: searchTerm)
        
        urlComponents?.queryItems = [searchQueryTerm]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let iTunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = iTunesSearch.results
                completion(nil)
            } catch {
                completion(error)
            }
            
        }
        
        task.resume()
        
    }
}

/*
 let session = URLSession.shared
 let task = session.dataTask(with: requestURL) { data, response, error in
     // handle the response or error here
 }
 task.resume()
*/
