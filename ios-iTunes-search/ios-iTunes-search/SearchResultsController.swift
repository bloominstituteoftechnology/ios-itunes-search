//
//  SearchResultsController.swift
//  ios-iTunes-search
//
//  Created by Lambda_School_Loaner_268 on 2/11/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation


class SearchResultController {
    // The initla URL to be added to
    let baseURL =  "https://itunes.apple.com/search?"
    // Container for the results of our searches
    var searchResults: [SearchResult] = []
    
    // MARK: - Methods
    // Func carries out search
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        guard let baseURL = URL(string: baseURL) else { return }
        // Creates a URLComponents object
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        // Creates a key-value for for the end of the URL (search term)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        // Set the above query item to the urlComponents (this formats the query objects appropriately)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        
        // Creates the actual URL out of the components
        guard let requestURL = urlComponents?.url else  {
            print("Error: Request URL is nil")
            completion(nil)
            return
        }
        
        // This is needed by the dataTask init to make a request of the API
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // A data task contains all information needed to request data
        // from an API and handles its reponse
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion(error)
                return
            }
            
            // Ensure data is returned
            guard let data = data  else {
                print("Error: No data returned from data task!")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults2 = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults2.results)
            }
            catch {
                print("Unable to decode data: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
        
        
        
    }
    
}
