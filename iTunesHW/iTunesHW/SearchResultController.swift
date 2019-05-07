//
//  SearchResultController.swift
//  iTunesHW
//
//  Created by Michael Flowers on 5/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults = [SearchResult]()
    
    func performSearch(with searchTerm: String, a resultType: ResultType, completion: @escaping (Error?) -> Void){
        
        //if we don't have any appendngPathComponents to add to the url, then we can just use the baseURL and go from there
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: "term", value: searchTerm)
        let resultQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQuery, resultQuery]
        
        //now that we have the url we can create the urlRequest
        guard let urlRequest = urlComponents?.url else  { completion(nil) ; return }
        
        //now that we have the request we can configure it
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error wth the data task rght here: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("error getting the data back n the perform search functon:\(NSError())")
                completion(NSError())
                return
            }
            
            //assuming we got the data back we need to decode it into our data model object
            let jd = JSONDecoder()
//            jd.keyDecodingStrategy = .convertFromSnakeCase //this is so that we don't have to do codingKeys in our struct
            
            do {
                let results = try jd.decode(SearchResults.self, from: data).results
                
                //now that we have drilled down from the top level of the json to our "results" key, we can grab that array and assign it to our data source array variable
                self.searchResults = results
                completion(nil)
                return
            } catch {
                print("error getting the data back n the perform search functon: \(error.localizedDescription)")
                completion(error)
                return
            }
        }.resume()
    }
}
