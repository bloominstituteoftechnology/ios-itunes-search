import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search")

class SearchResultController {
    //singleton
    static let shared = SearchResultController()
    private init() {}
    
    //this sorts through what was put in the search to see if it meets the requirement of the enums we specified in ResultType if not return error
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        // makes sure the url breakdown is correct and has the baseURL
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // searching if item is searchable a way to search
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        
        // searching if item is music, movie or app
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
       
        //things that can be searched has to have to values search, result
        urlComponents?.queryItems = [searchQueryItems, resultTypeQueryItem]
        
        //if searched item cannot be found at url log it
        guard let requestURL = urlComponents?.url else {
            NSLog("RequestURL is nil.")
            return
        }
        
        //asking url to get the information requested
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //calling the controller to get the data that was requested. if there is an error log it
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was a problem getting data from JSON: \(error)")
                completion(NSError())
            }
            //unwrapping the data to equal the data wanted in search if not found log it
            guard let data = data else {
                NSLog("No data found")
                completion(NSError())
                return
            }
            
            do {
                // allowing searchResults to have JSON get data and decode it to be something from ResultsList. Create a constant for this decoded SearchResults object
                let searchResults = try JSONDecoder().decode(ResultsList.self, from: data)
                // stating whatever the search is to equal the found results if not error
                self.searchResults = searchResults.results
                completion(NSError())
                
                
            } catch {
                //if unable to decode error
                NSLog("Unable to decodeJSON.")
                completion(NSError())
                
            }
            
        }.resume() //this calls dataTask to perform it's duty
    }
    
    var searchResults: [SearchResult] = [] //This will be the data source for the table view. Set the value of the searchResults variable in this model controller to the SearchResults' results array.

}
