

import UIKit

class SearchResultController {
    
    let baseURL = "https://itunes.apple.com/search"
    
    // Data source for the table view
    var searchResults: [SearchResult] = []
    
    // Completion
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        // Establish the base url for our search
        guard let baseURL = URL(string: baseURL)
            else {
                fatalError("Unable to construct baseURL")
        }
        
        // Decompose it into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        // Create the query items
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let secondSearchQueryItem = URLQueryItem(name:"entity", value: resultType.rawValue)
        
        // Add in the query items
        urlComponents.queryItems = [searchQueryItem, secondSearchQueryItem]
        
        // Recompose all those individual components back into a fully realized search URL
        guard let searchURL = urlComponents.url else {
            NSLog("Error construction search URL for \(searchTerm)")
            // completion
            completion(nil, NSError())
            return
        }
        // ^^ search URL created, but haven't done anything with it
        
        
        
        // Create a GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        // Asynchronously fetch data
        // Create a data task that is a URLSession, that runs the URL and fetches the data
        let dataTask = URLSession.shared.dataTask(with: request) {
            
            // Completion handler with three parameters:
            data, _, error in
            
            // Unwrap our data to ensure we have data and we don't have an error
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            // We know now that we have no error *and* we have data to work with
            
            // Convert the data to JSON
            
            do {
                // Declare the decoder
                let jsonDecoder = JSONDecoder()
                
                // Perform decoding
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                
                // Send back the results to the completion handler
                completion(self.searchResults, nil)
               
            // if it doesn't work, catch it with an error
            } catch {
                NSLog("Unable to decode data into search results: \(error)")
                completion(nil, error)
            }
        }
    }
    
}
