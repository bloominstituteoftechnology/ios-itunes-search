//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Niranjan Kumar on 10/29/19.
//  Copyright © 2019 Nar LLC. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
   
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void ) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        // review this concept
        let searchTermQueryItem1 = URLQueryItem(name: "term", value: searchTerm)
        let searchTermQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        //
        
        urlComponents?.queryItems = [searchTermQueryItem1, searchTermQueryItem2]
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion()
                return
            }
        
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode((AllSearchResults.self), from: data)
                self.searchResults = []
                self.searchResults.append(contentsOf: searchResults.results)
                completion()
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            completion()
        }
        
        task.resume()
        
    }
    
}


//Create your full request url by taking the baseURL, and adding the necessary query parameters (in the form of URLQueryItems.) to it using URLComponents.
//
//This function should use URLSession's dataTask(with: URL, completion: ...) method to create a data task. Remember to call .resume().
//
//In the completion closure of the data task:
//Give names to the return types.
//Check for errors. If there is an error, call completion with the error.
//Unwrap the data. If there is no data, call completion, and return NSError() in it.
//If you do get data back, use a do-try-catch block and JSONDecoder to decode SearchResults from the data returned from the data task. Create a constant for this decoded SearchResults object.
//Set the value of the searchResults variable in this model controller to the SearchResults' results array.
//Still in the do statement, call completion with nil.
//In the catch statement, call completion with error.
