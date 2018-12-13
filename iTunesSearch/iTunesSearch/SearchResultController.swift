import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    //data source for table view
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        //search
        var urlComponents = 
    }
}
