import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    
    static let shared = SearchResultController()
    private init() {}
    
    var searchResults: [SearchResult] = []
    
    //perform search
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //term is a way to search
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        //entity searches music, movies, app
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItems, resultTypeQueryItem]
        
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //fetching data
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was a problem getting data from JSON: \(error)")
                completion(NSError())
            }
            
            guard let data = data else {
                NSLog("No data found")
                completion(NSError())
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(NSError())
                
            } catch {
                NSLog("Unable to decodeJSON.")
                completion(NSError())
                
            }
        }.resume()
    }
}
