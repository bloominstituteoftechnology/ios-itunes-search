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
    
    //MARK: base of URL (never changes)
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    // MARK: - Perform Search func
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        // ** COMPLETION needs to be called everywhere, where the compailer could get out of this function
        
         //MARK: Build out the URL
        let searchURL = baseURL.appendingPathComponent("search")
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        // parameters for the URL
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let typeSearchQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // keeps all the parameters in an array, and it puts it in the http request accordinly
        components?.queryItems = [searchQueryItem, typeSearchQueryItem]
        
        // The array of componets is optional. Unwrap before use:
        guard let requestURL = components?.url else {
            completion()
            return
        }
        
        
        //MARK: Create a URLRequest
        
        //final completed URL, with protocol method
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //MARK: Perform the request (with a data task)
        
        // data = the JSON file we got
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Handle any errors
            if let error = error {
                NSLog("Error loading response: \(error)")
                completion()
                return
            }
            
            //MARK: (Ususally) decode the data
            
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
            completion()
        }
        
        // This is what performs the data task, or gets it to go to the server.
        // It doesn't run this entire function until it reads this .resume(). Then it goes back to the top of this func and runs accordingly
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
