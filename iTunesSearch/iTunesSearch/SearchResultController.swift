//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Carolyn Lea on 8/7/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

let baseMovieURL = URL(string: "https://itunes.apple.com/search?")!

import Foundation

class SearchResultController
{
    private enum HTTPMethod: String
    {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void)
    {
        var urlComponents = URLComponents(url: baseMovieURL, resolvingAgainstBaseURL: true)!
        
        let searchQueryItem = [URLQueryItem(name: "term", value: searchTerm), URLQueryItem(name: "&entity", value: "movie")]
        urlComponents.queryItems = searchQueryItem
        
        
        print(searchQueryItem)
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        print(requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error
            {
                NSLog("Error fetching data: \(error)")
                completion(nil, NSError())
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let items = searchResults.results
                completion(items, nil)
                print(items)
            } catch {
                NSLog("Unable to decode data into items: \(error)")
                completion(nil, error)
                return
            }
        }
        
        dataTask.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
