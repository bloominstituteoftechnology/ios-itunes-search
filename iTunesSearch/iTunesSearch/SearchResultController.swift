//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Yvette Zhukovsky on 10/22/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation



enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}


class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")
    
    var searchResults: [SearchResult] = []
    
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void){
        
        guard var urlComponents = URLComponents(url: baseURL!, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let termSearchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entitySearchQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [termSearchQueryItem, entitySearchQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error Constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, _, error in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Unable to unwrap data")
                completion(nil, NSError())
                return
            }
            
            do {
                // Declare, customize, use the decoder
                let jsonDecoder = JSONDecoder()
                
                
                // Perform decoding into [Person] stored in PersonSearchResults
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let people = searchResults.results
                
                // Send back the results to the completion handler
                completion(people, nil)
                
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil, error)
                //        return
            }
        }
        dataTask.resume()
        
    }
}
