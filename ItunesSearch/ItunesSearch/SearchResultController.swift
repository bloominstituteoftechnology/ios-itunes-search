//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Lambda_School_Loaner_218 on 12/3/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/")
    var searchResults: [SearchResult] = []
    
    func preformSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        guard let url = baseURL else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let termQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [entityQueryItem, termQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL not valid: \(NSError())")
            completion(NSError())
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
                
            }
            let decoder = JSONDecoder()
            
            do {
                let resultSearch = try decoder.decode(SearchResults.self, from: data)
                DispatchQueue.main.async {
                self.searchResults = resultSearch.ressults
                completion(nil)
                }
            } catch let networkError {
                print("Unable to decode data into object of type [SearchResult]: \(networkError)")
                completion(networkError)
            }
        }.resume()
    }
}
