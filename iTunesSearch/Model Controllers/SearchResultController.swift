import Foundation

class SearchResultController {
    
    //MARK: Properties
    var searchResults: [SearchResult] = []
    
    let baseURl = URL(string: "https://itunes.apple.com/")
    
    
    //MARK: Search Function
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        
        
    }
}
