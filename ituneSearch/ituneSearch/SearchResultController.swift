//
//  SearchResultController.swift
//  ituneSearch
//
//  Created by Lambda_School_Loaner_241 on 3/13/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    let searchResults: [SearchResult] = [] // data source for the table view
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([ResultType]) -> Void){
        // SearchResultController number 4
        
    }
    
}
