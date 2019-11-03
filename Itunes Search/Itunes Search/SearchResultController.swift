//
//  SearchResultController.swift
//  Itunes Search
//
//  Created by Nicolas Rios on 11/2/19.
//  Copyright © 2019 Nicolas Rios. All rights reserved.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController {
    let baseURL = URL(string:"https://itunes.apple.com/search?term = yelp&entity=software")!
    var search: [SearchResult] = []

    func performSearch(searchItem:String,resultType:
        [ResultType],completion: @escaping() -> Void) {
        var urlComponents = URLComponents(url:baseURL,
         resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name:"search",value: "searchterm")
        urlComponents?.queryItems [searchQueryItem]
        guard let requestURL = urlComponents?.url else {
            print("the request url is nil")
            completion()
            return
            
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
    
        let tasks = URLSession.shared.dataTask(with:request) { data,_,error in
            if let error = error {
                print ("Error fetching date from data task")
                return
                
                
            }
            
            guard let date = data else {
                print("no data return from data task")
                return
                
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy =
            .convertFromSnakeCase
            
            do{
              let searchResults = try
                jsonDecoder.decode(SearchResults.self,from:data)
                self.search.append(contentsOf:
                    searchResults.results)
                
            } catch {
                print("unable to decode data\(error)")
                
            }
            completion()
        }  .resume()
      }
}
