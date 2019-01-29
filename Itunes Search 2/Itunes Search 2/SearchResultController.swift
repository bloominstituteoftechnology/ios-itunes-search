//
//  SearchResultController.swift
//  Itunes Search 2
//
//  Created by Michael Flowers on 1/29/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, a resultType: ResultType, Completion: @escaping (Error?)-> Void){
        
        //becuase our search has a queryparameter we must construct our url via components
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let urlQueryItem1 = URLQueryItem(name: "term", value: searchTerm)
        let urlQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [urlQueryItem1, urlQueryItem2]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Error constructing the url. URL does not work")
            Completion(nil)
            return }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data from data task: \(error.localizedDescription)")
                Completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error getting data back. No data.")
                Completion(NSError())
                return
            }
            
            //try to decode the data we got back from the network call
            let jd = JSONDecoder()
            
            do{
                //Parse the json at the highest level in your model file
                let searchResult = try jd.decode(SearchResults.self, from: data)
                
                //now we can drill down and get the array of objects
                let searchResultsArray = searchResult.results
                
                //now that we have access to the array of objects we fetched from the network call, assign them to the data source of truth array
                self.searchResults = searchResultsArray
                Completion(nil)
            }catch {
                NSLog("Error fetching data from data task: \(error.localizedDescription)")
                Completion(error)
                return
            }
        }
        
    }
}
