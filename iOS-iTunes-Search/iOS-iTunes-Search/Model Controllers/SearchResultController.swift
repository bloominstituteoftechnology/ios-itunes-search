//
//  SearchResultController.swift
//  iOS-iTunes-Search
//
//  Created by Vijay Das on 1/31/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void?){
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let urlQueryItem1 = URLQueryItem(name: "term", value: searchTerm)
        let urlQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [urlQueryItem1, urlQueryItem2]
     
        
        guard let urlRequest = urlComponents.url else {
            NSLog("Unable to construct search URL for \(searchTerm)")
            completion(nil)
            return }
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error) in
            if let error = error {
                NSLog(

                
            }
        }
            
    
        
        
        
        
        
    
    
    
    
    
    
}

}
