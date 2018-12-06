import Foundation
let endpoint = "https://itunes.apple.com/search"

class SearchResultController {
    
    static let shared = SearchResultController()
    private init() {}
    
    var searchResults: [SearchResult] = []
    
    //perform search
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?,NSError?) -> Void) {
        guard let baseURL = URL(string: endpoint)
            else {
                fatalError("Unable to construct baseURL")
        }
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {
                fatalError("Unable to resolve baseURL to components")
        }
        //term is a way to search
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        //entity searches music, movies, app
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchQueryItems, resultTypeQueryItem]
        
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        //create request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        //fetching data
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil, error as NSError)
            }
        }
    
        dataTask.resume()
    }
}
