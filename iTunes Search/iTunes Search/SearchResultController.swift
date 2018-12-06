import UIKit

class SearchResultController {
    
   static let endpoint = "https://itunes.apple.com/search?parameter"
    
    let baseURL = URL(string: endpoint)

    var searchResults: [SearchResult] = []
    
    static func performSearch(with searchTerm: String, completion: @escaping ([ResultType]?, Error?) -> Void) {
        
        guard let baseURL = URL(string: endpoint)
            else { fatalError("Unable to construct baseURL") }
        
        // Decompose it into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        // Add in the search term, if you have more than one just add it to the array
        urlComponents.queryItems = [searchQueryItem]
        
        // Recompose all those individual components back into a fully
        // realized search URL
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError()) // you could do a fatal error instead
            return
        }
        
        // Create a GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET" // "Please fetch information for me", simplest REST you can do, equivalent to "read"
        
        // Asynchronously fetch data
        // Once the fetch completes, it calls its handler either with data
        // (if available) _or_ with an error (if one happened)
        // There's also a URL Response but we're going to ignore it
        let dataTask = URLSession.shared.dataTask(with: request) {
            // This closure is sent three parameters:
            data, _, error in
            
        guard error == nil, let data = data else {
            if let error = error { // this will always succeed
                NSLog("Error fetching data: \(error)")
                completion(nil, error) // we know that error is non-nil
            }
            return
        }

}

}
}
