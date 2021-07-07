
import UIKit

class SearchResultController {
    
    // Base URL
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    // Data source for the table view
    private(set) var searchResults: [SearchResult] = []
    
    // Search function that calls from the table view controller which takes in a search term and sets self.searchResults to the result of the search
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        // Build up to the API end point we want to hit
        
        let searchResultsURL = baseURL.appendingPathComponent("search")
        
        // Add components because we are using a search query
        var components = URLComponents(url: searchResultsURL, resolvingAgainstBaseURL: true)
        
        // Create query items
        let firstSearchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let secondSearchQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // Add query items to an array that will be added when building the URL
        components?.queryItems = [firstSearchQueryItem, secondSearchQueryItem]
        
        // Create URL out of the components
        guard let requestURL = components?.url else {
            NSLog("Couldn't make requestURL from \(components)")
            completion(NSError())
            return
        }
        
        // Make a request by creating an instance of URLRequest...
        var request = URLRequest(url: requestURL)
        // ... and setting the method we are using
        request.httpMethod = "GET"
        
        // Reach out to the network
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // After we get the response, check to see if there is an error
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            
            // Unwrap the data
            guard let data = data else {
                // In case there is no error _and_ no data...
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            // Do-Try-Catch Block to decode the data returned from the data task
            do {
                let searchResults = try JSONDecoder().decode(SearchResult.TopLevelSearchResults.self, from: data)
                // set the results from our decoded searchResults to our searchResults array
                self.searchResults = searchResults.results
                completion(nil)
                return
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil)
                return
            }
        }
        
        .resume()
    }
    
}
