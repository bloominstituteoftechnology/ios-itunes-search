//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Farhan on 9/11/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation

class SearchResultController{
    
    let baseURL = URL(string: "https://itunes.apple.com")
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void){
      
        let searchURL = baseURL?.appendingPathComponent("search")
        var components = URLComponents(url: searchURL!, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        components?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = components?.url else {
            NSLog("error in generating URL")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Fetching Error: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No Data Error: \(error)")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let mediaSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                print ("success")
                print(requestURL)
                self.searchResults = mediaSearch.results
                completion(nil)
            } catch {
                NSLog("Decode Error: \(error)")
                completion(error)
                return
            }
            

        }.resume()

//            let jsonDecoder = JSONDecoder()
//            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//
//            do {
//                let personSearch = try jsonDecoder.decode(PersonSearchResults.self, from: data)
//                print("success")
//                self.people = personSearch.results
//                completion(nil)
//            } catch {
//                NSLog("Decode Error: \(error)")
//                completion(error)
//                return
//            }
//
//
//            }.resume()

        
    }

    
}
