//
//  SearchResultController.swift
//  iTunes
//
//  Created by Nikita Thomas on 10/22/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation


class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var searchResults: [SearchResult] = []
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping
        ([SearchResult]?, String?) -> Void) {
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")}
        
        
        
        urlComponents.queryItems = [URLQueryItem(name: "term", value: searchTerm), URLQueryItem(name: "media", value: ("music"))]
        
        guard let searchURL = urlComponents.url else {
            NSLog("No url for \(searchTerm)")
            completion(nil, "No url for \(searchTerm)")
            return
        }
        
        var requestURL = URLRequest(url: searchURL)
        
        //        URLSession.shared.configuration.httpAdditionalHeaders = [:]
        //        URLSession.shared.configuration.httpAdditionalHeaders?["Accept"] = "text/json"
        requestURL.httpMethod = "GET"
        requestURL.addValue("Paw/2.3.3 (Macintosh; OS X/10.11.4) GCDHTTPRequest", forHTTPHeaderField: "User-Agent")
        let dataTask = URLSession.shared.dataTask(with: requestURL) {
            data, _, error in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("unable to unwrap data")
                completion(nil, "unable to unwrap data")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                // print(data as NSData)
                
                let decodedSearchResults = try jsonDecoder.decode(ResultList.self, from: data)
                print(decodedSearchResults)
                self.searchResults = decodedSearchResults.results
                completion(self.searchResults, nil)
                //                let finalResult = decodedSearchResults.results
                //                completion(finalResult, nil)
                
            } catch {
                completion(nil, "Error with JSON Decoding \(error)")
                print(String(data: data, encoding: .utf8)!)
                print(requestURL)
                
            }
        }
        dataTask.resume()
    }
}
