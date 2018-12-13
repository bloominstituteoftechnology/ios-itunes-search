import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    typealias completetionHandler = (Error?) -> Void
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping completetionHandler) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItems, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Bad URL request")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                NSLog("Couldn't load JSON: \(error)")
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
