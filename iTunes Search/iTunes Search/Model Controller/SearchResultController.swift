//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Ilgar Ilyasov on 9/18/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Enum
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Properties
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    // MARK: - Fetching data
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let termQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryitem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponent.queryItems = [termQueryItem, entityQueryitem]
        
        guard let requestURL = urlComponent.url else {
            NSLog("Search url is invalid: \(urlComponent)")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("Error. No data returned.)")
                completion()
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion()
            } catch {
                NSLog("Error decoding data: \(error)")
                completion()
            }
        }
        dataTask.resume()
    }
}
