//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by morse on 10/29/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    var searchResults: [SearchResult] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    
}
