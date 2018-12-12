
import UIKit

struct SearchResult: Codable {
    
    let title: String // JSON = artistName
    let creator: String // JSON = trackName
    
    // Allow Codable to find the matching keys, despite renaming throughout application
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    // Object that represents JSON at the highest level, containing resultCount and results keys
    struct TopLevelSearchResults: Codable {
        let results: [SearchResult]
    }
}
