//
//  SearchResultController.swift
//  The Itunes Search
//
//  Created by Michael Flowers on 1/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class SearchResultController {
    
    //add the base url
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = [] //this will be the data source for the tableViewController
    
    /*
 SINCE WE DECLARED THE DATA SOURCE OF TRUTH ARRAY IN THE SAME FILE AS WE DECLARED OUR NETWORK FUNCTION, WE DO NOT, I REPEAT WE DO NOT INCLUDE THE OPTIONAL MODEL OBJECT ARRAY IN THE CLOSURE.
 */
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void?) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm) // "entity = resulttype"
        let queryItems = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents.queryItems = [ searchQueryItems,queryItems ]
        
        guard let urlRequest = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil)
            return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            //check to see if there is an error
            if let error = error {
                NSLog("Error fetching data \(error.localizedDescription)")
            }
            
            //check to see if we got some data back.
            guard let data = data else {
                NSLog("Error fetching data, No data returned")
                completion(nil)
                return}
            
            //we got data back, so lets use json decoder because we are getting it from a url.
            let jd = JSONDecoder()
            
            do {
                let searchResultsArray = try jd.decode(SearchResults.self, from: data)
                //WE GOT DATA BACK, ASSIGN IT TO OUR DATA SOURCE ARRAY
                self.searchResults = searchResultsArray.results
                completion(nil)
                
            } catch {
                NSLog("Error, uable to decode data into model object: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
        }.resume()
    }
    
}
