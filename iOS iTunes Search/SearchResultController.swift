//
//  SearchResultController.swift
//  iOS iTunes Search
//
//  Created by Andrew Ruiz on 9/3/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search?term=yelp&entity=software")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
    }
    
    // funcName(parameter: (ParameterTypes) -> ReturnType)

}
