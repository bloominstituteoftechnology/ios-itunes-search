//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Welinkton on 9/18/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

private enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}


class SearchResultController {
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm:String, resultType:ResultType, completion: @escaping ([SearchResult]?, NSError?) -> Void){
        // components
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        // queryitems
        let searchQueryItem =  URLQueryItem(name: "search", value: searchTerm)
        let entitiyQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // call the url into the array
        urlComponents.queryItems = [searchQueryItem, entitiyQueryItem]
        
        // check against it and return error
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing the search url for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        //call the url
        var request = URLRequest(url:requestURL)
        
        // get raw value
        request.httpMethod = HTTPMethod.get.rawValue
        
        // get the dataTasks
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fecthing data: \(error)")
                completion(nil, NSError())
                return
            }
            guard let data = data else {
                NSLog("Error fetching data. No data")
                completion(nil, NSError())
                return
        }
        // Get the JSON decoder, create the Do.Catch.Try
            // convert from snakeCase
        // Retrieve the data and make into the SearchResults
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let newSearch = try jsonDecoder.decode(SearchResults.self, from: data)
            } catch  {
                NSLog("Unable to decode data: \(error)")
                completion(nil,NSError())
                return
            }
        }
        dataTask.resume()
    }
}
