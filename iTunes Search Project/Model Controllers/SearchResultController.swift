//
//  SearchResultController.swift
//  iTunes Search Project
//
//  Created by macbook on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {

    // Data Source for the tableView
    var searchResults: [SearchResult] = []
    
   
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    // MARK: - Perform Search
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        
         // Build out the URL
        let searchURL = baseURL.appendingPathComponent("search")
        
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)// not sure yet
//        let musicSearchQueryItem = URLQueryItem(name: "entity", value: "music")
//        let movieSearchQueryItem = URLQueryItem(name: "entity", value: "movie")
//        let appSearchQueryItem = URLQueryItem(name: "entity", value: "software")
        //let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchQueryItem]     // not sure for what and if I need this
               
        guard let requestURL = components?.url else {
            completion()
            return
        }
        
        
        // Create a URLRequest
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Perform the request (with a data task)
        
        // data = the JSON file we got
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Handle any errors
            if let error = error {
                NSLog("Error loading response: \(error)")
                completion()
                return
            }
            
            // (Ususally) decode the data
            
            guard let data = data else {
                NSLog("No data returned from person search")
                completion()
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                
                self.searchResults = searchResults.results
                completion() // call completion with nill?
                
            } catch {
                NSLog("Unable to decode data into PersonSerach: \(error)")
                completion()  // call with error??  ^^ i think
                
            }
            
            completion()  // not sure if to leave it here
        }
        // This is what performs the data task, or gets it to go to the server
        dataTask.resume()
    }
    
    
    
}


// MARK: - HTTP Method
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
