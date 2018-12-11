import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void ) {
        
        //MARK: Form url we will use to search in the API
        var components = URLComponents(url: baseURL!, resolvingAgainstBaseURL: true)
        
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItems = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        components?.queryItems = [searchQueryItems, resultTypeQueryItems]
        
        guard let requestURL = components?.url
            else {
            NSLog("Failed to put together URL.")
            return
        }
        print(requestURL)
        //MARK: Data Task
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            guard let data = data  else{
                NSLog("Could not get data.")
                completion(NSError())
                return
            }
            do {
                let items = try JSONDecoder().decode(SearchResult.SearchResults.self, from: data)
                self.searchResults = items.results
                completion(nil)
                return
            } catch {
                NSLog("Could not decode JSON with JSONDecoder.")
                completion(NSError())
                return
            }
        }.resume()
        
    }
    
}
