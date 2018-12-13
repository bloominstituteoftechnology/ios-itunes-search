import UIKit

class SearchResultController {
    
    // add a baseURL constant set to the iTunes Search API
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    // search results array, data source for the table view
    var searchResults: [SearchResult] = []
    
    // Create a performSearch function with a searchTerm: String, a resultType: ResultType parameter,
    // and a completion closure. The completion closure should return an NSError?.
    // Helpful resource for "as a parameter to another function"
    // http://goshdarnclosuresyntax.com/ [For Swift]
    // funcName(parameter: (ParameterTypes) -> ReturnType)
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, NSError?) -> Void) {
        
        // Create your full request url by taking the baseURL, and adding the necessary query parameters (in the form of URLQueryItems.) to it using URLComponents.
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let searchRequestURL = urlComponents?.url
            else {
                NSLog("Couldn't make URL from components.")
                completion(nil, NSError())
            return
        }
        
        // Make a request
        var request = URLRequest(url: searchRequestURL)
        request.httpMethod = "GET"
     
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Check for errors. If there is an error, call completion with the error.
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, NSError())
                return
            }
            
            // Check for errors. If there is an error, call completion with the error.
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil, NSError())
                return
            }
            
            // Not needed here; especially since we're using an API provided by Apple.
            // let jsonDecoder = JSONDecoder()
            // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                // If you do get data back, use a do-try-catch block and JSONDecoder to decode SearchResults from the data returned from the data task. Create a constant for this decoded SearchResults object.
                // Set the value of the searchResults variable in this model controller to the SearchResults' results array.
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                // Still in the do statement, call completion with nil.
                completion(self.searchResults, nil)
                return
            } catch {
                NSLog("Unable to decode data: \(error)")
                // In the catch statement, call completion with nil for the array of recipes, and the error thrown in the catch block.
                completion(nil, NSError())
                return
            }
        }
        
        // You could also just write .resume() if you don't want to set something to a variable. It would be attached to the bracket above.
        dataTask.resume()
        
    }
    
}
