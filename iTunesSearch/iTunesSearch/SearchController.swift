//
//  SearchController.swift
//  iTunesSearch
//
//  Created by Steven Leyva on 6/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class SearchResultControllers {
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    var searchResult: [SearchResult] = []
    
    
func perfomSearch(searchTerm: String, completion: @escaping () -> Void) {
   var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
    urlComponents?.queryItems = [searchTermQueryItem]
    guard let requestURL = urlComponents?.url else {
        print("request URL is nil")
        completion()
        return
    }
    let request = URLRequest(url: requestURL)
    
           
    URLSession.shared.dataTask(with: request) { data
    }
    }
    
}
