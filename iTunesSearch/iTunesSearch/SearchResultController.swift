import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    //model
    static let shared = SearchResultController()
    private init () {}
    
    //data source for table view
    var searchResults: [SearchResult] = []
    
    func searchResult(at indexPath: IndexPath) -> SearchResult {
        return searchResults[indexPath.row]
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        //search
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        //request
        guard let requestURL = urlComponents?.url else {
            NSLog("error constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //fetching data
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was a problem getting data from JSON: \(error)")
                completion(NSError())
            }
            guard let data = data else {
                NSLog("No data found")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                NSLog("error decoding JSON: \(error)")
                completion(nil)
                
            }
        }
        dataTask.resume()
    }
}
