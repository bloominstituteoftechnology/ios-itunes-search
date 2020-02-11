//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Enrique Gongora on 2/11/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import Foundation

class SearchResultController {
    //MARK: - Variables
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    //MARK: - Functions
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        // Create a URL components object from our base URL
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // Create a key-value pair for the end of the URL
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        // Set the above query item to the urlComponents
        urlComponents?.queryItems = [searchTermQueryItem]
        
        // Create a formal URL from the components
        guard let requestURL = urlComponents?.url else { print("request URL is nil"); completion(NSError()); return }
        
        // Rquired by the dataTask initializer to make a request of the API
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // This is the object that will communicate with the API
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fecthing data \(error)")
                return
            }
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResult.results)
                completion(nil)
            }catch {
                NSLog("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(error)
            }
        }.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
