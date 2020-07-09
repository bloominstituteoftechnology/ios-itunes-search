//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by B$hady on 7/8/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com")!
    private lazy var searchURL = URL(string: "/search", relativeTo: baseURL)!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let typeSearchQueryItem = URLQueryItem(name: "entity", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem,typeSearchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
       
         let task = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
               if let error = error {
                   print("error fetching data: \(error)")
                   completion()
                   return
               }
        
        
            
    }
        task.resume()
    










    }


}
