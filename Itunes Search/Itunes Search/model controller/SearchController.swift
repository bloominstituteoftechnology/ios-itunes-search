//
//  SearchController.swift
//  Itunes Search
//
//  Created by Iyin Raphael on 9/18/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchController{
    
    var searchResults = [SearchResult]()
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void){
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem =  URLQueryItem(name: "term", value: searchTerm)
        let searchQueryType = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, searchQueryType]
        
        guard let requestUrl = urlComponents?.url else {
            NSLog( "Error requesting url: \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                NSLog("Error fetching data \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else{
                NSLog("Error fetching data. No data returned)")
                completion(nil, error)
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(self.searchResults, nil)
            } catch {
                NSLog("Unable to  decode data into people: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
}
