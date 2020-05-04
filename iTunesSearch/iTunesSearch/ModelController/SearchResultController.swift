//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Enzo Jimenez-Soto on 5/4/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import Foundation



class SearchResultController{
    
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(searchTerm:String, resultType: ResultType, completion: @escaping (Error?)->Void){
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name:"term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name:"entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchQueryItem,entityQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Error creating request URL")
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error{
                NSLog("Error: \(error)")
                _ = completion(error)
                return
            }
            guard let data = data else {
                NSLog("Error: No data")
                _ = completion(nil)
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonResults = try decoder.decode(SearchResults.self, from: data)
                print(jsonResults)
                self.searchResults = jsonResults.results
                
                
                
                _ = completion(nil)
            } catch {
                NSLog("Error decoding")
                _ = completion(nil)
                return
            }
        }.resume()
    }
    
    
    
    var searchResults: [SearchResult] = []
    
}

