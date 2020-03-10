//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Bhawnish Kumar on 3/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

class SearchResultController {
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void ) {
        
    }
}
