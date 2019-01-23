//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Cameron Dunn on 1/22/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import Foundation

class SearchResultController{
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
   func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchTermQuery = URLQueryItem(name: "term", value: searchTerm)
        let searchMediaQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchTermQuery, searchMediaQuery]
        guard let requestURL = urlComponents.url else{
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil)
            return
    }
    URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
        if let error = error{
            NSLog("There was an error: \(error)")
            completion(nil)
            return
        }
        guard let data = data else{
            NSLog("Error fetching data. No data returned.")
            completion(nil)
            return
        }
        do{
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let findings = try jsonDecoder.decode(SearchResults.self, from: data)
            self.searchResults = findings.results
            completion(nil)
        }catch{
            NSLog("unable to decode data into results: \(error)")
            completion(nil)
            return
        }
        }.resume()
    }
}
