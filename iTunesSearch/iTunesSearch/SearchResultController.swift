//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Jorge Alvarez on 1/14/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?term=")! // search
    var searchResults: [SearchResult] = [] // data source for the table view
    
    // The completion closure should take an Error? argument and should return Void. As a first measure of help for closure syntax, look at the "As a parameter to another function" section of this page. You're obviously free to ask a PM for help as well.
                                                                                    // (Error?)
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        // I know it's not working right because im not filter for apps/music/movies
        
        var testURL = baseURL
        testURL = URL(string: "\(baseURL)" + searchTerm)!
        
        var newComponents = URLComponents(url: testURL, resolvingAgainstBaseURL: true)
        // this was the old one
        //var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // this was adding ?
        //let searchTermQueryItem = URLQueryItem(name: "search?term", value: searchTerm) // name: "search?media"
        //urlComponents?.queryItems = [searchTermQueryItem]
        
        // this also wasn't really working
        //let searchURL = baseURL.appendingPathComponent("?term") // prints 000000.0
        
        // guard let requestUrl = urlComponents?.url else
        guard let requestUrl = newComponents?.url else {
            print("request URL is nil")
            completion() 
            return
        }
        NSLog("\(requestUrl)")
        NSLog("\(testURL)")
        // https://itunes.apple.com/search?term=jack+johnson. example
        // https://itunes.apple.com/??term=Baby what I got, always puts ?
        
        /*
        7.In the completion closure of the data task:

            1.Give names to the return types.
            2.Check for errors. If there is an error, call completion with the error.
            3.Unwrap the data. If there is no data, call completion, and return NSError() in it.
            4.If you do get data back, use a do-try-catch block and JSONDecoder to decode SearchResults from the data returned from the data task. Create a constant for this decoded SearchResults object.
            5.Set the value of the searchResults variable in this model controller to the SearchResults' results array.
            6.Still in the do statement, call completion with nil.
            7.In the catch statement, call completion with error.
        */
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            
            
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("no data returned from data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            completion() // NSError()
        }.resume()
        
        /*
         func searchForPeopleWith(searchTerm: String, completion: @escaping () -> Void) {
             var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
             let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
             urlComponents?.queryItems = [searchTermQueryItem]
             
             guard let requestUrl = urlComponents?.url else {
                 print("request URL is nil")
                 completion()
                 return
             }
             
             var request = URLRequest(url: requestUrl)
             request.httpMethod = HTTPMethod.get.rawValue
             // https://swapi.co/api/people/?search=[search term]
             URLSession.shared.dataTask(with: request) { (data, _, error) in
                 if let error = error {
                     print("Error fetching data: \(error)")
                     return
                 }
                 
                 guard let data = data else {
                     print("no data returned from data task")
                     return
                 }
                 
                 let jsonDecoder = JSONDecoder()
                 do {
                     let personSearch = try jsonDecoder.decode(PersonSearch.self, from: data)
                     self.people.append(contentsOf: personSearch.results)
                 } catch {
                     print("Unable to decode data into object of type [Person]: \(error)")
                 }
                 completion()
             }.resume()
         }
         */
    }
}

