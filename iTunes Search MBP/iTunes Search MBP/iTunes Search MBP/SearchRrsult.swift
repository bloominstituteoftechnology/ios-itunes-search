
import Foundation

struct SearchResult: Codable {
    
    let title: String?
    let crator: String?
    let type: String?
    let collectionName: String?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case crator = "artistName"
        case type = "kind"
        case collectionName = "primaryGenreName"
        
    }
    struct SearchResults: Codable {
      let results: [SearchResult]
    }
}
