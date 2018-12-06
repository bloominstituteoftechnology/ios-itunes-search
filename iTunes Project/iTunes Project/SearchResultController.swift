import UIKit

class SearchResultController{
    let endpoint = "https://itunes.apple.com/search"
    

    
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
    
        guard let baseURL = URL(string: endpoint) else {fatalError("Unable to construct baseURL") }
    
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {
                fatalError("Unable to resolve baseURL to components")
            }
    
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
    
        urlComponents.queryItems = [searchQueryItem, resultTypeQueryItem]
    
        guard let searchURL = urlComponents.url else { return }
    

        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
    
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
        
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
