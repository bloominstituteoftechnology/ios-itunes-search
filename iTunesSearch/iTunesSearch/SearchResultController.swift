//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by admin on 9/3/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    // Changed completion: (Error) to @ escaping (), may need to chagne back
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        let entityURL = baseURL.appendingPathComponent("entity")
        
        var components = URLComponents(url: entityURL, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchItem]

        //Skipping "SearchResultController 5-7"
        
        
        
    }
}
