
import Foundation

struct SearchResult: Codable {
    
    let title: String?
    let crator: String
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case crator = "artistName"
        
    }
    struct SearchResults: Codable {
      let results: [SearchResult]
    }
}
