//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Harmony Radley on 4/6/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")
    
    private var searchResults: [SearchResult] = []
    
    private var task: URLSessionTask?
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: Error?  -> Void) {
        
    }
}
