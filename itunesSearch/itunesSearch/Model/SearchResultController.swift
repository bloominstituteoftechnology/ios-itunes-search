//
//  SearchResultController.swift
//  itunesSearch
//
//  Created by Matthew Martindale on 3/12/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
    }
}
