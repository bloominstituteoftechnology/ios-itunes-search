//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Rick Wolter on 10/29/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import Foundation


class SearchResultController{
    
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")
    var searchResults: [SearchResult] = []
    
    
    
    func performSearch(searchTerm: String,resultType: ResultType, completion: @escaping (Error?) -> Void) {}
}
