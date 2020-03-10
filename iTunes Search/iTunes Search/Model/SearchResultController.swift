//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Mark Gerrior on 3/10/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

struct SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!

    private(set) var searchResults: [SearchResult] = []

    func performSearch(searchTerm: String, resultType: ResultType, completion: (Error?) -> Void) {
        
    }
}
