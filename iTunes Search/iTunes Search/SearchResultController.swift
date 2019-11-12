import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class SearchResultController {
    static let shared = SearchResultController()
    init() {}
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        // Establish the base url for our search
        guard let baseURL = URL(string: "https://itunes.apple.com/search") else {
            fatalError("Unable to construct baseURL")
        }
        
        // Decompose it into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        // Create the query item using `search` and the search term
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        // Add in the search term
        urlComponents.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        //REcompose all those individual components back into a fully realized search URL
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        
        //Create a GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.GET.rawValue // "GET"
        
        // Asynchronously fetch data
        // Once the fetch completes, it calls its handler either with data
        // (if available) _or_ with an error (if one happened)
        // There's also a URL Response but we're going to ignore it
        let dataTask = URLSession.shared.dataTask(with: request) {
            // This closure is sent three parameters:
            data, _, error in
            
            // This acts like a guard but we can't express it that way
            // in Swift, so we have to use `if`
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
            }
            guard let data = data else {
                NSLog("No data found.") ; completion(NSError()) ; return
            }
            
            // We know now we have no error. We have data to work with
            
            // Convert the data to JSON
            do {
                // Declare, customize, use the decoder
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                // Send back the results to the completion handler
                completion(nil)
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil)
                // return
            }
        }
        
        // A data task needs to be run. To start it, you call `resume`.
        // Newly-initiated task begin in a suspended state, so you need to call this method to start the task."
        dataTask.resume()
        
        
        
        
    }
}
