//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Sammy Alvarado on 7/8/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation

class SearchResultController {

    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []

    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {

    }



}
