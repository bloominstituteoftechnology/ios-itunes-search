import Foundation

class SearchResultController: Codable {
    
    static let endpoint = "https://itunes.apple.com/search?"
    var searchResults: [SearchResult] = []
    
    static func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        //base URL for search
        guard let baseURL = URL(string: endpoint)else {
            fatalError("Unable to create baseURL")
        }
        
        //separate baseURL into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL components")
        }
        
        //create query item
        
        let searchQueryTerm = URLQueryItem(name: "term", value: searchTerm)
        let searchQueryEntity = URLQueryItem(name: "entity", value: "\(resultType)")
        
        urlComponents.queryItems = [searchQueryTerm, searchQueryEntity]
        
        //recompose required components back into a API conforming URL
        //a fully qualified search term looks like...
        ///https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError()) // could use a fatalError()
            return
        }
        
        //create GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        //create dataTask
        let dataTask = URLSession.shared.dataTask(with: request) {
            //closure with 3 params
            data, _, error in
            
            //unwrap data
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error unwrapping data: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            //convert data to JSON
            do{
                //create decoder
                let decoder = JSONDecoder()
                
                //decode data into [] from searchResults
                let searchResults = try decoder.decode(SearchResults.self, from: data)
                let results = searchResults.results
                
                // return to completion handler
                completion(results, nil)
                
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
    
}
