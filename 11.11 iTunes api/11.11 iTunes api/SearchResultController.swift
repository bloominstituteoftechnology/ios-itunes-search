import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    
    static let shared = SearchResultController()
    // datasource for tableView
    var searchResults: [SearchResults] = []
    
    typealias CompletionHandler = (Error?) -> Void
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping CompletionHandler) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItems, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let error = error {
            NSLog("Could not load JSON: \(error)")
            completion(NSError())
        }
            
            guard let data = data else {
                NSLog("No data found")
                completion(NSError())
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(ResultsList.self, from: data)
                self.searchResults = searchResults.results
                completion(NSError())
            } catch {
                NSLog("Unable to decode JSON")
                completion(NSError())
            }
    } .resume()
}
}
