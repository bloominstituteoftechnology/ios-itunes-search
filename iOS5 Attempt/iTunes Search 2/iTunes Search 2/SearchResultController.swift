//
//  SearchResultController.swift
//  iTunes Search 2
//
//  Created by Jaspal on 1/22/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // TODO: Make this a URL type
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    // Table View Data Source
    var searchResults: [SearchResult] = []
    
    // Would SearchResults work? I know that SearchResults isn't technically needed in some cases.
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, NSError?) -> Void) {
        
        // URL Components
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // URL Query Items
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        // This is how we obtain `musicTrack`
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // Things that were added but not mentioned in the README
        
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let searchRequestURL = urlComponents?.url
            else {
                NSLog("Couldn't make URL from components.")
                completion(nil, NSError())
            return
        }
        
        // Not needed, since we're only using GET
        var request = URLRequest(url: searchRequestURL)
        request.httpMethod = "GET"
        
        // End of things that were not mentioned in the README
        
        // Give names to the return types
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, NSError())
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil, NSError())
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(self.searchResults, nil)
                return
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, NSError())
                return
            }
            
        }
        
        dataTask.resume()
    }
    
}
