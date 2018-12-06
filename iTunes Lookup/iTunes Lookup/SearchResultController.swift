import Foundation

class SearchResultController {
    
    static let shared = SearchResultController()
    private init () {}
    
    var searchResults: [SearchResult] = []
    
    let endpoint = "https://itunes.apple.com/search"
    
    func performSearch(with searchTerm: String, result: ResultType, completion: @escaping (NSError?) -> Void) {

        guard let baseURL = URL(string: endpoint)
            else {
                fatalError("Unable to construct baseURL")
        }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: result.rawValue)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        urlComponents.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, _, error in
            
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(NSError())
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                
                let searchResults = try jsonDecoder.decode(SearchResult.SearchResults.self, from: data)
                
                self.searchResults = searchResults.results
                

                completion(nil)
                
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(NSError())
            }
        }
        
     dataTask.resume()
        
    }
}
