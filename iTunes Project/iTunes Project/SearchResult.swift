import UIKit

struct SearchResult: Codable {
    let title: String //trackName
    let creator: String //artistName
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    struct SearchResults: Codable {
        let results: [SearchResult]
    }
}


