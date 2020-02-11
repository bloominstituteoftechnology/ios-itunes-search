//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Enrique Gongora on 2/11/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import Foundation

class SearchResultController {
    //MARK: - Variables
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    //MARK: - Functions
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {

    }
}
