//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Nonye on 5/4/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        //MARK: - CREATE REQUEST FOR URL
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let parameters: [String : String] = ["term" : searchTerm, "entity" : resultType.rawValue]
        
        let queryItems = parameters.compactMap({URLQueryItem(name: $0.key, value: $0.value)})
        
        urlComponents?.queryItems = queryItems
        
        print(urlComponents?.description)
        
        guard let requestURL = urlComponents?.url else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //MARK: - DATA TASK
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data \(error)")
                return
            }
            guard let data = data else {
                completion()
                return
                
            }
            print (String(data: data, encoding: .utf8))
            //MARK: - DECODING
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchResults.results)
            } catch {
                NSLog("Unable to decode data \(error)")
                
            }
            completion()
        }
        .resume()
    }
}
