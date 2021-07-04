//
//  Model.swift
//  iTunes Search
//
//  Created by Madison Waters on 12/5/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

class Model {
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
//    var resultType: ResultType? {
//        didSet {
//            DispatchQueue.main.async {
//                self.updateHandler?()
//            }
//        }
//    }
//    
//    var searchResultsController = SearchResultsController() {
//        didSet {
//            DispatchQueue.main.async {
//                self.updateHandler?()
//            }
//        }
//    }
    
    let searchResultsTableViewController = SearchResultsTableViewController()
    
    var searchResults: [SearchResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    func numberOfResults() -> Int {
        return searchResults.count
    }
    
    func getSearchResult(at index: Int) -> SearchResult {
        return searchResults[index]
    }
    
    func searchItunes(for string: String) {
//        guard let resultType = resultType else { return }
//        searchResultsController.performSearch(searchTerm: string, resultType: resultType) { searchResults, error in
//            
//            if let error = error {
//                NSLog("Error fetching search results: \(error)")
//                return
//            }
//            guard let searchResults = searchResults else { return }
//            self.searchResults = searchResults
//        }
    }
    
    func updateSearchType() {
        
    }
    
}
