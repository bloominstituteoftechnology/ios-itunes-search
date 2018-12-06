import UIKit

class SearchResultController {
    
   let searchURL = "https://itunes.apple.com/search"
    
    //let baseURL = URL(string: searchURL)

    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, completion: @escaping ([ResultType]?, Error?) -> Void) {
        
        guard let baseURL = URL(string: searchURL)
            else { fatalError("Unable to construct baseURL") }
        
        // Decompose it into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let searchQueryItem = URLQueryItem(name: "entity", value: searchTerm)
        let resultQueryItem = URLQueryItem(name: "term", value: ResultType.software.rawValue) // ResultType.movie.rawValue, ResultType.musicTrack.rawValue)
        
        // Add in the search term, if you have more than one just add it to the array
        urlComponents.queryItems = [searchQueryItem, resultQueryItem]
        
        // Recompose all those individual components back into a fully
        // realized search URL
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError()) // you could do a fatal error instead
            return
        }
        
        // Create a GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET" // "Please fetch information for
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            // This closure is sent three parameters:
           
            
            
            guard error == nil, let data = data else {
                if let error = error { // this will always succeed
                    NSLog("Error fetching data: \(error)")
                    completion(nil, NSError()) // we know that error is non-nil
                }
                return
            }
                do {
                    let jsonDecoder = JSONDecoder()
                    let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                    
                    self.searchResults = searchResults.results
                    
                    
                    completion(nil, error)
                } catch {
                    NSLog("error decoding data \(error)")
                    completion(nil, error)
                    
                }
            }
            dataTask.resume()
        
        }
}


