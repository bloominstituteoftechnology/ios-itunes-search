//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by alfredo on 1/19/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

class SearchResultController{
    
    //MARK: - Properties
    

    let baseURL: URL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = [] //data source for the table view
 
    //MARK: - Methods
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?)->Void){
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil!")
//            completion(NSError())
            completion(nil)
            return
        }
    
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
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
        }
        .resume()
    }
}
