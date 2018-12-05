
import UIKit

struct SearchResult: Codable {
    var title: String // trackName
    var creator: String // artistName
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artist = "artistName"
    }
}

// Object that represents JSON at the highest level, that contains the resultCount and results keys
struct SearchResults {
    let results: [SearchResult]
}
